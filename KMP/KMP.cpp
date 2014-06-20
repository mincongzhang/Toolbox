int KMPStrMatching(string T, string P, int *N, int start){
	int j = 0;
	int i = start;
	int pLen = P.length();
	int tLen = T.length();

	if(tLen - start<pLen) 
	return(-1);

	while (j < pLen && i < tLen) {
		if (j == -1 || T[i] == P[j])
			i++, j++;
		else
			j = N[j];
	}

	if(j >= pLen)
		return (i-pLen);
	else
		return (-1);
}

int findNext(string P){
	int m = P.length();
	assert( m > 0 );

	int *next = new int[m];
	assert( next != 0);
	next[0] = -1;

	int j = 0,k = -1;
	while(j < m-1){
		while (k >= 0 && P[k] != P[j]){
			k = next[k];
			j++; k++; next[j] = k;
		}
	}	
	return next;
}
