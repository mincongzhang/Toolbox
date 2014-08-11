#include "mycomplex.h"

//MyComplex
MyComplex MyComplex::operator+(const MyComplex & a){
	MyComplex result;
	result._real = _real + a._real;
	result._imag = _imag + a._imag;
	return result;
};

MyComplex MyComplex::operator-(const MyComplex & a){
	MyComplex result;
	result._real = _real - a._real;
	result._imag = _imag - a._imag;
	return result;
};

MyComplex MyComplex::operator*(const MyComplex & a){
	MyComplex result;
	result._real  = _real*a._real - _imag*a._imag;
	result._imag = _real*a._imag + _imag*a._real;
	return result;
}

MyComplex MyComplex::operator()(const double & a,const double & b){
	_real = a; 
	_imag = b; 
	return *this;	
}

MyComplex & MyComplex::operator=(const MyComplex & num){
	if(this == &num) return *this;
	_real = num._real;
	_imag = num._imag;
	return *this;
}

MyComplex power(MyComplex complex_num,unsigned int power_var){
	MyComplex result(0.0,0.0);

	if(power_var == 0)	return result;

	result = complex_num;
	unsigned int iter = 1;
	while(iter<power_var){
		result = result * complex_num;
		iter++;
	}
	return result;
}

