#include <iostream>
using namespace std;

class Bar {
    public:
        Bar(int input)
        {
            data = input;
        }
        Bar(){}
        int get42()
        {
            return data;
        }
        int data;
};

class Foo {
    public:
        
        Foo()
        : foo(bar.get42()) {
        bar(15);
        
        }
    
        Bar bar;
        int foo;
};

int main()
{
    Foo foo;
    cout << foo.foo << endl;
}
