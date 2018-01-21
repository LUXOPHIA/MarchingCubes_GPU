# LUX.GPU.OpenGL

* IOpenGL = **interface**
    * プロパティ
        * **property** PFD :TPixelFormatDescriptor
        * **property** PFI :Integer
        * **property** RC :HGLRC
    * メソッド
        * **procedure** BeginGL;
        * **procedure** EndGL;
        * **procedure** InitOpenGL;
        * **procedure** ApplyPixelFormat( **const** DC_:HDC );
        * **function** glGetString( **const** Name_:GLenum ) :String;
        * **function** glGetInteger( **const** Name_:GLenum ) :GLint;

* TOpenGL = **class**( TInterfacedObject, IOpenGL )
    * プロパティ
        * **property** PFD :TPixelFormatDescriptor
        * **property** PFI :Integer
        * **property** RC :HGLRC
    * 定数
        * **class function** DefaultPFD :TPixelFormatDescriptor;
    * メソッド
        * **constructor** Create;
        * **destructor** Destroy;
        * **procedure** BeginGL;
        * **procedure** EndGL;
        * **procedure** InitOpenGL;
        * **procedure** ApplyPixelFormat( **const** DC_:HDC );
        * **function** glGetString( **const** Name_:GLenum ) :String;
        * **function** glGetInteger( **const** Name_:GLenum ) :GLint;
