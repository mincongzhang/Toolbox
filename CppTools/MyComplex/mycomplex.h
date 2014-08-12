class MyComplex
{
	double _real;
	double _imag;

public:
	//constructor1
	MyComplex():_real(0.0),_imag(0.0){};

	//constructor2
	MyComplex(double a ,double b):_real(a),_imag(b){};

	//constructor3
	MyComplex(const MyComplex & c):_real(c._real),_imag(c._imag){};

	MyComplex operator+(const MyComplex &);
	MyComplex operator-(const MyComplex &);
	MyComplex operator*(const MyComplex &);
	MyComplex operator()(const double &,const double &);
	MyComplex & operator=(const MyComplex &);

	friend MyComplex power(MyComplex,unsigned int);

	double real(){return _real;}
	double imag(){return _imag;}
};