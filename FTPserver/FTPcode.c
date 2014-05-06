#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <netinet/in.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <dirent.h>
#include <time.h>

// Maximum number of clients
#define MAX_CLIENT 128

//Root account shall be used for the following 2 ports 
#define SERVER_CMD_PORT 21
#define SERVER_DAT_PORT 20
#define PAS_PORT 6000

#define SIZE 128

//Mode to set up data connections, Active or Passive  枚举 
enum data_conn_mode {
	kDataConnModeActive, kDataConnModePassive
};
int pas_port=PAS_PORT;
int max_speed;

struct sockaddr_in servAddr; /* Local Server address */

//Structure to store client information: name, IP address, ...
struct Client {
	char user[128];
	char pass[128];
	unsigned short data_port;
	struct in_addr sin_addr;  //IP address
	enum data_conn_mode mode; //mode
	char cwd[128];
	int power;
	double traffic;
	double speed;
	//Other information
};

char username[]="is09";
char admin[]="admin";
char password[]="bupt";
char topDir[SIZE];
//Used to listen for command connection;
int server_sockfd;
//Used to store the socket-fd returned by accept();
int client_sockfd; 

/*Array of client structure, client_socketfd is used as index.
For example, if client_socketfd of a client is 4, then the structure of client[4] stores his information. */
struct Client client[MAX_CLIENT];

//Creat a socket for server, server_sockfd is given a value
int create_server_socket();

// Set up data connection in Active mode
int data_conn_active(int fd, struct in_addr *sin_addr, unsigned short port);

// Reaction of command LIST or NLST: Sending directory and file list;
// dir is an absolute path
int send_list(int sockfd, char *dir);

//Reaction of command RETR
int send_file(int sockfd, char *fileName);

//Reaction of command STOR
int upload_file(int sockfd, char *fileName);
//Set up data connection in Passive mode
int data_conn_passive(unsigned short port);

int main(int argc, char *argv[])
{
	int client_len;
	if(argc==2){
		max_speed=atoi(argv[1]);
		printf("The max speed is %d byte/s\n",max_speed);
	}
	else max_speed=1000;
	int pasv_fd;
	struct sockaddr_in client_address; //此数据结构用做bind、connect、recvfrom、sendto等函数的参数，指明地址信息。 
	int result;
	char tempBuf[SIZE] ="";
	fd_set readfds, testfds; // a set of sockets to be monitored

	//create a socket and server_sockfd will be set.
	create_server_socket( );

	FD_ZERO(&readfds);
	FD_SET(server_sockfd, &readfds); // add server_sockfd to fd_set

	/* 
    FD_ZERO(fd_set   *fdset);将指定的文件描述符集清空，在对文件描述符集合进行设置前，必须对其进行初始化，如果不清空，由于在系统分配内存空间后，通常并不作清空处理，所以结果是不可知的。   
	FD_SET(fd_set   *fdset);用于在文件描述符集合中增加一个新的文件描述符。   
	FD_CLR(fd_set   *fdset);用于在文件描述符集合中删除一个文件描述符。   
	FD_ISSET(int   fd,fd_set   *fdset);用于测试指定的文件描述符是否在该集合中。
    */

	char currentDir[SIZE]="";
	getcwd(topDir,sizeof(topDir));
	while(1) {
		char buf[SIZE];
		int fd;
		int nread;//receiving

		testfds = readfds; //used to store readfds temporarily
		printf("server waiting\n\n\n\n");
		


		/* select(int maxfd, fd_set *readset, fd_set *writeset, fd_set *exceptset, const struct timeval *timeout) is used to monitor events of 
		a set of sockets. If timeout sets to NULL, wait forever and return only when one of the descriptors is ready for I/O. 
		A return value <0 indicates an error, 0 indicates a timeout. */
		result = select(FD_SETSIZE, &testfds, (fd_set *)0, (fd_set *)0, (struct timeval *)0); //??????
		if(result< 0) {
			perror("ftp_server");
			exit(1);
		}

		for(fd = 0; fd < FD_SETSIZE; fd++) {
			// checking which socket triggers a read event.
			if(FD_ISSET(fd, &testfds)) {  //测试指定的文件描述符是否在该集合中。

				if(fd == server_sockfd) {   //fd是server的时候 
					// Processing new connection requests.
					client_len = sizeof(client_address);
					client_sockfd = accept(server_sockfd, (struct sockaddr *)&client_address,&client_len);
					// add server_sockfd to fd_set
					FD_SET(client_sockfd, &readfds); 
					client[client_sockfd].sin_addr.s_addr = client_address.sin_addr.s_addr;
					printf("adding client on fd %d\n", client_sockfd);
					sprintf(buf, "220 (wxftp 1.0)\r\n");
					write(client_sockfd, buf, strlen(buf));
				} //然后fd+1了 ，然后就给client commands了 
				else {
					//Processing commands from client
					// check if anything received from socket fd;
					// nread  stores number of bytes received.
					ioctl(fd, FIONREAD, &nread); 		//???????		
					if(nread == 0) {
CLOSE:
						/* no data received, indicating the client has closed FTP command connection. */
						close(fd);
						memset(&client[fd], 0, sizeof(struct Client));
						FD_CLR(fd, &readfds); //clear fd
						printf("removing client on fd %d\n", fd);
					} 
					else {
						//read commands from socket fd and process;
						read(fd, buf, nread);//read fd是什么？读取fd里的buf和 nread？？ 
						buf[nread] = '\0';
						printf("serving client on fd %d: %s\n", fd, buf);
						printf("Handling client: %s \r\n\n", inet_ntoa(client_address.sin_addr));


						if(strncmp(buf, "USER", 4) == 0) {   //比较两个字符串前4个字符，一样就返回 0 
							// Receiving user name;
							// You need to check if it is a valid user; 
							sscanf(&buf[4], "%s", client[fd].user); //从buf前四个里读进user用户名中；sscanf从一个字符串中读进与指定格式相符的数据
							if((strcmp(client[fd].user,username)==0)||(strcmp(client[fd].user,admin)==0)){
								if(strcmp(client[fd].user,username)==0){
									client[fd].power=0;
								}
								else client[fd].power=1;
								sprintf(buf, "331 Password required for %s.\r\n", client[fd].user); //要求密码 
								write(fd, buf, strlen(buf));//把用户名写进fd里面 ，然后就跳回开头server waiting了！ 写进fd的才会在client显示出来 
							}
							else{
								printf("This user does not exist.\n");
								sprintf(buf, "530 Username incorrect.\r\n");
								write(fd, buf, strlen(buf));
								goto CLOSE;
							}
						}
						else if(strncmp(buf, "PASS", 4) == 0) {//这时候已经输入完了用户名 
							sscanf(&buf[4], "%s", client[fd].pass); 
							if(strcmp(client[fd].pass,password)==0){
								sprintf(buf, "230 Login successfully \r\n"); //成功进入 
                               
								write(fd, buf, strlen(buf)); 
								getcwd(client[fd].cwd,sizeof(client[fd].cwd));//这里把cwd写进去了
							}
							else{
								printf("This user does not exist.\n");
								sprintf(buf, "530 Password incorrect.\r\n");
								write(fd, buf, strlen(buf)); 
								goto CLOSE;
							}//输入密码 adding  
							write(fd, buf, strlen(buf)); 
							// Authenticate the user
						}
						else if (strncmp(buf, "QUIT", 4) == 0) {
							//Processing QUIT command			
							sprintf(buf, "221 Goodbye.\r\n");
							write(fd, buf, strlen(buf));
							close(fd);
							memset(&client[fd], 0, sizeof(struct Client));
							FD_CLR(fd, &readfds);
							printf("removing client on fd %d\n", fd);
						}
						else{
							chdir(client[fd].cwd);
							printf("The client is %s.\n\n",client[fd].user);
							if(strncmp(buf, "PWD", 3) == 0) {
								getcwd(client[fd].cwd,sizeof(client[fd].cwd));//这里把cwd写进去了 
								client[fd].cwd[sizeof(client[fd].cwd)-1]='\0';//
								printf("%s  \r\n\r\n",client[fd].cwd);
								sprintf(buf,"257 %s  \r\n",client[fd].cwd);
								write(fd, buf, strlen(buf));
							} 
							else if(strncmp(buf, "CWD", 3) == 0) {
								if(client[fd].power==1){
									sscanf(&buf[4], "%s", buf); 
									if(chdir(buf)==0){
										getcwd(client[fd].cwd,sizeof(client[fd].cwd));//这里再把当前cwd写进去了 
										//client[fd].cwd[sizeof(client[fd].cwd)-1]='\0';//
										printf("%s  \r\n\r\n",client[fd].cwd);
										//输出改变后的pwd 
										sprintf(buf,"250 Directory successfully changed to %s \r\n   ",client[fd].cwd);
									}
									else{
										sprintf(buf,"550 Failed to change directory.\r\n");
									}
								}
								else{
									sprintf(buf,"550 Failed to change directory.\r\n");	
								}
								write(fd, buf, strlen(buf));
							} 
							else if(strncmp(buf, "CDUP", 4) == 0) {//change to parent directory  回到父目录 
								//Processing CDUP command
								chdir("..");
								//输出改变后的pwd
								getcwd(client[fd].cwd,sizeof(client[fd].cwd));//这里再把当前cwd写进去了 
								client[fd].cwd[sizeof(client[fd].cwd)-1]='\0';//
								printf("%s\r\n\r\n",client[fd].cwd);
								sprintf(buf,"250 %s\r\n",client[fd].cwd);
								write(fd, buf, strlen(buf));
							} 
							else if(strncmp(buf, "PORT", 4) == 0) {
								//Processing PORT command;
								/* store IP address of the client in client[fd].sin_addr; store port number following PORT command in client[fd].data_port; set client[fd].mode as kDataConnModeActive;... */
								sscanf(&buf[4], "%s", tempBuf); 
								if(port(fd,tempBuf)==0)
									sprintf(buf, "200 Port command successful.\r\n");
								else
									sprintf(buf, "421 Port failed.\r\n");
								write(fd, buf, strlen(buf));
							} 
							else if(strncmp(buf, "LIST", 4) == 0 || strncmp(buf, "NLST", 4) == 0) {
								//Processing LIST or NLST command
								int sockfd;
								if(client[fd].mode == kDataConnModeActive) {
									sockfd = data_conn_active(fd, &client[fd].sin_addr, client[fd].data_port);
								} 
								else if (client[fd].mode == kDataConnModePassive) {
									sockfd = pasv_fd;
								}
								int result = 0;
								if (sockfd != -1) {
									sprintf(buf,"150 Opening data connection for directory list.\r\n");
									write(fd, buf, strlen(buf));
									if(send_list(sockfd, client[fd].cwd) == 0) {
										sprintf(buf, "226 Transfer ok.\r\n");
									} 
									else {
										sprintf(buf, "550 Error encountered.\r\n");
									}
								}
								else {
									sprintf(buf, "550 Error encountered.\r\n");
								}
								write(fd, buf, strlen(buf));
								close(sockfd);
								close(pasv_fd);
							}
							//make new dir
							else if((strncmp(buf, "MKD", 3) == 0)) 
							{
								char filename[SIZE]="";
								sscanf(&buf[3], "%s", filename);
								{
									if(mkdir(filename,0) ==0){
										sprintf(buf,"250 create folder %s successfully!\n", filename);
									}
									else {
										sprintf(buf,"550 create folder failed.\n");
									}
								}
								write(fd, buf, strlen(buf));
							}
							//delete file
							else if(strncmp(buf, "DELE", 4) == 0){
								char filename[SIZE]="";
								sscanf(&buf[4], "%s", filename);
								if(remove(filename) ==0){
									sprintf(buf,"250 delete %s successfully!\n", filename);
								}
								else{
									sprintf(buf,"550 delete failed.\n");
								}
								write(fd, buf, strlen(buf));
							}
							//Rename from
							else if((strncmp(buf, "RNFR", 4) == 0)){
								memset(&tempBuf, 0, SIZE*sizeof(char));
								sscanf(&buf[4], "%s", tempBuf);
								printf("%s\n",tempBuf);
								sprintf(buf,"350 Ready for RNTO.\r\n");
								write(fd, buf, strlen(buf));
							}
							//Rename to
							else if ((strncmp(buf, "RNTO", 4) == 0)){
								char newName[SIZE]="";
								sscanf(&buf[4], "%s", newName);
								printf("%s\n",tempBuf);
								printf("%s\n",newName);
								if(rename(tempBuf,newName) ==0){
									sprintf(buf,"250 rename successfully!\n");
								}
								else{
									sprintf(buf,"550 rename failed.\n");
								}
								write(fd, buf, strlen(buf));
							}
							else if((strncmp(buf, "RETR", 4) == 0)){
								//Processing RETR command
								printf("RETR is executed by %d.\n",fd);
								int sockfd;
								char fileName[SIZE];
								sscanf(&buf[4], "%s", fileName);
								if(client[fd].mode == kDataConnModeActive) {
									sockfd = data_conn_active(fd, &client[fd].sin_addr, client[fd].data_port);
								} 
								else if (client[fd].mode == kDataConnModePassive) {
									sockfd = pasv_fd;
								}
								int result = 0;
								if (sockfd != -1) {
									sprintf(buf,"150 Opening data connection for directory list.\r\n");
									write(fd, buf, strlen(buf));
									if(send_file(sockfd, fileName) == 0) {
										sprintf(buf, "226 Transfer ok.\r\n");
									} 
									else {
										sprintf(buf, "550 Error encountered.\r\n");
									}
								}
								else{
									sprintf(buf, "425 Can't open data connection.\r\n");
								}
								write(fd, buf, strlen(buf));
								close(sockfd);
							}
							else if((strncmp(buf, "STOR", 4) == 0)){
								//Processing STOR command
								int sockfd;
								char fileName[SIZE];
								sscanf(&buf[4], "%s", fileName);
								if(client[fd].mode == kDataConnModeActive) {
									sockfd = data_conn_active(fd, &client[fd].sin_addr, client[fd].data_port);
								} 
								else if (client[fd].mode == kDataConnModePassive) {
									sockfd = pasv_fd;
								}
								int result = 0;
								if (sockfd != -1) {
									sprintf(buf,"150 Opening data connection for directory list.\r\n");
									write(fd, buf, strlen(buf));
									if(upload_file(sockfd, fileName) == 0) {
										sprintf(buf, "226 Transfer ok.\r\n");
									} 
									else {
										sprintf(buf, "550 Error encountered.\r\n");
									}
								}								
								else{
									sprintf(buf, "425 Can’t open data connection.\r\n");
								}
								write(fd, buf, strlen(buf));
								close(sockfd);
								close(pasv_fd);

							}
							else if(strncmp(buf, "PASV", 4) == 0){
								printf("PASV is executed.\n");
								int p1,p2,sockfd;
								int data_fd;
								pas_port++;
								struct sockaddr_in clinAddr;
								int len;
								pasv_fd= data_conn_passive(pas_port);
								p2=pas_port%256;
								p1=pas_port/256;
								client[fd].mode=kDataConnModePassive;
								sprintf(buf, "227 Entering Passive Mode (192,168,116,128,%d,%d).\r\n",p1,p2);
								write(fd, buf, strlen(buf));
								printf("pasv_fd is %d\n",pasv_fd);
								getsockname(pasv_fd,(struct sockaddr*)&clinAddr,&len);
								if((pasv_fd=accept(pasv_fd,(struct sockaddr*)&clinAddr,&len))<0){
									printf("pasv_fd is %d\n",pasv_fd);
									printf("data passive accept failed\n");
									close(pasv_fd);
								}
							}
							else{

							}
							chdir(topDir);
						}
					}
				}
			}
		}
	}


	return 0;
}

int create_server_socket()
{
	struct sockaddr_in servAddr; /* Local address */
	//创建socket
	if((server_sockfd=socket(PF_INET, SOCK_STREAM, 0))<0) {
		perror("socket");
	}
	int opt=1;
	
	memset(&servAddr, 0, sizeof(servAddr)); /*ip地址替换为0*/ 
	servAddr.sin_family = PF_INET;
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servAddr.sin_port =htons(SERVER_CMD_PORT);
	setsockopt(server_sockfd,SOL_SOCKET,SO_REUSEADDR,&opt,sizeof(opt) );
	//绑定socket
	if ((bind(server_sockfd, (struct sockaddr *) &servAddr,sizeof(servAddr))) < 0) {
		printf("bind() failed.\n");
	}
	if (listen(server_sockfd, MAX_CLIENT)<0) printf("litsen() failed.\n");

}

int data_conn_active(int fd, struct in_addr *sin_addr, unsigned short port)
{
	printf("data_conn_active is executed.\n");
	/* set up data connection in active mode. 
	The input parameters are IP address and port number of the client.
	The return value is socket file descriptor created for data connection. */ 
	struct sockaddr_in clntAddr; /* Clinet address */

	int sock_fd;/*socket ddesriptor for data connection*/


	memset(&clntAddr,0,sizeof(struct sockaddr_in));
	clntAddr.sin_family=AF_INET;
	clntAddr.sin_addr.s_addr=(*sin_addr).s_addr;
	clntAddr.sin_port=htons(port);

	//创建data port socket
	if((sock_fd=socket(AF_INET, SOCK_STREAM, 0))<0){
		close(sock_fd);
		return -1;
	}
	int opt=1;
	
	memset(&servAddr, 0, sizeof(struct sockaddr_in)); /*ip地址替换为0*/ 
	servAddr.sin_family = AF_INET;
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servAddr.sin_port =htons(SERVER_DAT_PORT);
	setsockopt(sock_fd,SOL_SOCKET,SO_REUSEADDR,&opt,sizeof(opt) );
	//绑定socket
	if ((bind(sock_fd, (struct sockaddr *) &servAddr,sizeof(struct sockaddr_in))) < 0) {
		close(sock_fd);
		printf("data_conn_active bind() failed.\n");
		return -1;
	}
	if ((connect(sock_fd,(struct sockaddr *) &clntAddr,sizeof(struct sockaddr_in)))<0){
		close(sock_fd);
		printf("data_conn_active connect() failed.\n");
		return -1;
	}
	return sock_fd;

	/* Create a socket and connect to client whose IP address and port number is given as input parameters. */ 

}

int send_list(int sockfd, char *dir)
{

	/* Find out directory and file list and send to client.
	For input parameters, sockfd are the socket fd of data connection, and dir is the string including sub-directory and file list under current directory.
	The return value is 0 if sending OK, otherwise -1 is returned. */

	/* To get sub-directory and file list, you can execute shell command by using system( ) or use functions as opendir( ) and readdir( )  */
	printf("send_list is executed.\n");
	DIR *currentDir;
	struct dirent *ptr;
	char buf[SIZE]="";
	if((currentDir=opendir(dir))==NULL){
		return -1;
	}
	ptr=readdir(currentDir);
	ptr=readdir(currentDir);

	while((ptr=readdir(currentDir))!=NULL){
		//printf("%s\n",ptr->d_name);
		sprintf(buf,"%s\r\n",ptr->d_name);
		write(sockfd, buf, strlen(buf));
	}
	closedir(currentDir);
	return 0;
}
int port(int fd,char *tempBuf){
	printf("port is executed.\n");
	//the port comand return something like "127,0,0,1,25,60"
	//input:
	//2 : client feedback string of PORT command
	//return:
	//ftp data socket 

	// user to trans digital to string of ipaddress
	char localbuffer[16]={'\0'};

	// sotr ipaddress 
	char clientipaddress[128]={'\0'};

	// parse PORT command from client
	unsigned short portinfoparser[6];

	// port number of client
	unsigned short clientport;

	// index
	int index=0;

	printf("LOG:\t client PORT output:%s\n", tempBuf);

	// start to split "127,0,0,1,25,60"
	char * tok = strtok(tempBuf, ",");

	while(tok != NULL){
		portinfoparser[index++]=(unsigned short)atoi(tok);

		tok=strtok(NULL,",");
	}
	for (index=0; index<4; index++) {
		memset(localbuffer, 0, 16*sizeof(char));
		sprintf(localbuffer, "%d", (int)portinfoparser[index]);
		strcat(clientipaddress, localbuffer);
		if(index!=3)strcat(clientipaddress, ".");
	}


	// get client port
	client[fd].data_port = portinfoparser[4]*256+portinfoparser[5];
	client[fd].sin_addr.s_addr=inet_addr(clientipaddress);
	client[fd].mode=kDataConnModeActive;


	// get client ip address

	return 0;

}
       time_t startT, endT;

       double totalT;
       
int send_file(int sockfd, char *fileName){
	//fail return -1
	printf("send_file is exexuted.\n");
	char buf[SIZE]="";
	int file_fd;
	int length;
	int tot=0;//total transmission
	double delay;
	if((file_fd=open(fileName,O_RDONLY,0))<0) return -1;
	 startT = time( NULL );//计时 
	while((length=read(file_fd,buf,SIZE))!=0){
        tot=tot+length;
		delay=delay+((double)length)/((double)max_speed);
		if(delay>=1)
			sleep((int)delay);
		delay=delay-((double)(int)delay);
		write(sockfd, buf, length);
		
	}
	if(delay!=0.0) sleep(1);
	close(file_fd);
	endT = time( NULL );
    totalT = difftime(endT,startT);
	printf("%s is sent to the fd %d\r\n",fileName,sockfd);
	printf("total transmission: %d bytes\r\n",tot);
	printf("transmission time: %f second(s)\r\n",totalT);
	printf("speed: %f byte(s)/second(s)\r\n",(tot/totalT));
	return 0;
} 
int upload_file(int sockfd, char *fileName){
	//fail return -1
	printf("upload_file is exexuted.\n");
	char buf[SIZE]="";
	int file_fd;
	int length;
	double delay;
	if((file_fd=open( fileName, O_WRONLY|O_CREAT|O_TRUNC,0644))<0) return -1;
	int tot=0;//total transmission)<0) return -1;
	 startT = time( NULL );//计时 
	while ((length=read(sockfd, buf, SIZE*(sizeof(char)))) > 0){
        tot=tot+length;
		delay=delay+((double)length)/((double)max_speed);
		if(delay>=1)
			sleep((int)delay);
		delay=delay-((double)(int)delay);
		write(file_fd, buf, length);
	}
	if(delay!=0.0) sleep(1);
	close(file_fd);
	endT = time( NULL );
    totalT = difftime(endT,startT);
	printf("%s has been stored on the server from %d fd\r\n", fileName,sockfd);
	printf("total transmission: %d bytes\r\n",tot);
	printf("transmission time: %f second(s)\r\n",totalT);
	printf("speed: %f byte(s)/second(s)\r\n",(tot/totalT));
	
	return 0;
}
int data_conn_passive(unsigned short port){
	printf("data_coon_pasive is exexuted.\n");
	int sock_fd;
	if((sock_fd=socket(PF_INET, SOCK_STREAM, 0))<0) return -1;
	int opt=1;
	
	memset(&servAddr, 0, sizeof(struct sockaddr_in)); /*ip地址替换为0*/ 
	servAddr.sin_family = PF_INET;
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servAddr.sin_port =htons(port);
	setsockopt(sock_fd,SOL_SOCKET,SO_REUSEADDR,&opt,sizeof(opt) );
	if ((bind(sock_fd, (struct sockaddr *) &servAddr,sizeof(struct sockaddr_in))) < 0){
		close(sock_fd);
		printf("passive bind() failed.\n");
		return -1;
	}
	if (listen(sock_fd, MAX_CLIENT)<0){
		close(sock_fd);
		printf("passive litsen() failed.\n");
		return -1;
	}

	return sock_fd;
}
