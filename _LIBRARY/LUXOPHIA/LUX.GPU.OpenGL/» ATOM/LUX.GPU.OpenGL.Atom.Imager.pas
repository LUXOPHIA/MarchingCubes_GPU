unit LUX.GPU.OpenGL.Atom.Imager;

interface //#################################################################### ■

uses Winapi.OpenGL, Winapi.OpenGLext,
     LUX, LUX.Data.Lattice.T1, LUX.Data.Lattice.T2, LUX.Data.Lattice.T3,
     LUX.GPU.OpenGL.Atom;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLSample

     IGLSample = interface( IGLAtomer )
     ['{E95328D2-B7D7-4A7C-9367-8A4E554E4F81}']
       ///// アクセス
       function GetWrapU :GLint;
       procedure SetWrapU( const WrapU_:GLint );
       function GetWrapV :GLint;
       procedure SetWrapV( const WrapV_:GLint );
       function GetWrapW :GLint;
       procedure SetWrapW( const WrapW_:GLint );
       function GetMinFilter :GLint;
       procedure SetMinFilter( const MinFilter_:GLint );
       function GetMagFilter :GLint;
       procedure SetMagFilter( const MagFilter_:GLint );
       ///// プロパティ
       property WrapU     :GLint read GetWrapU     write SetWrapU    ;
       property WrapV     :GLint read GetWrapV     write SetWrapV    ;
       property WrapW     :GLint read GetWrapW     write SetWrapW    ;
       property MinFilter :GLint read GetMinFilter write SetMinFilter;
       property MagFilter :GLint read GetMagFilter write SetMagFilter;
       /////メソッド
       procedure Use( const BindI_:GLuint );
       procedure Unuse( const BindI_:GLuint );
     end;

     //-------------------------------------------------------------------------

     TGLSample = class( TGLAtomer, IGLSample )
     private
     protected
       _WrapU     :GLint;
       _WrapV     :GLint;
       _WrapW     :GLint;
       _MinFilter :GLint;
       _MagFilter :GLint;
       ///// アクセス
       function GetWrapU :GLint;
       procedure SetWrapU( const WrapU_:GLint );
       function GetWrapV :GLint;
       procedure SetWrapV( const WrapV_:GLint );
       function GetWrapW :GLint;
       procedure SetWrapW( const WrapW_:GLint );
       function GetMinFilter :GLint;
       procedure SetMinFilter( const MinFilter_:GLint );
       function GetMagFilter :GLint;
       procedure SetMagFilter( const MagFilter_:GLint );
       ///// メソッド
       procedure SetParamI( const Name_:GLenum; const Value_:GLint );
       procedure SetParamF( const Name_:GLenum; const Value_:GLfloat );
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property WrapU     :GLint read GetWrapU     write SetWrapU    ;
       property WrapV     :GLint read GetWrapV     write SetWrapV    ;
       property WrapW     :GLint read GetWrapW     write SetWrapW    ;
       property MinFilter :GLint read GetMinFilter write SetMinFilter;
       property MagFilter :GLint read GetMagFilter write SetMagFilter;
       ///// メソッド
       procedure Use( const BindI_:GLuint );
       procedure Unuse( const BindI_:GLuint );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager<_TPixel_>

     IGLImager = interface( IGLAtomer )
     ['{22F971D6-65FD-4F42-80ED-743253890A8C}']
       ///// アクセス
       function GetKind :GLenum;
       procedure SetKind( const Kind_:GLenum );
       function GetTexelF :GLenum;
       procedure SetTexelF( const TexelF_:GLenum );
       function GetPixelF :GLenum;
       procedure SetPixelF( const PixelF_:GLenum );
       function GetPixelT :GLenum;
       procedure SetPixelT( const PixelT_:GLenum );
       ///// プロパティ
       property Kind   :GLenum read GetKind   write SetKind  ;
       property TexelF :GLenum read GetTexelF write SetTexelF;
       property PixelF :GLenum read GetPixelF write SetPixelF;
       property PixelT :GLenum read GetPixelT write SetPixelT;
       /////メソッド
       procedure Bind;
       procedure Unbind;
       procedure Use( const BindI_:GLuint );
       procedure Unuse( const BindI_:GLuint );
       procedure SendData;
     end;

     //-------------------------------------------------------------------------

     TGLImager = class( TGLAtomer, IGLImager )
     private
     protected
       _Field  :TGLSample;
       _Kind   :GLenum;
       _TexelF :GLenum;
       _PixelF :GLenum;
       _PixelT :GLenum;
       ///// アクセス
       function GetKind :GLenum;
       procedure SetKind( const Kind_:GLenum );
       function GetTexelF :GLenum;
       procedure SetTexelF( const TexelF_:GLenum ); virtual;
       function GetPixelF :GLenum;
       procedure SetPixelF( const PixelF_:GLenum );
       function GetPixelT :GLenum;
       procedure SetPixelT( const PixelT_:GLenum );
     public
       constructor Create( const Kind_:GLenum );
       destructor Destroy; override;
       ///// プロパティ
       property Field  :TGLSample read   _Field                 ;
       property Kind   :GLenum    read GetKind   write SetKind  ;
       property TexelF :GLenum    read GetTexelF write SetTexelF;
       property PixelF :GLenum    read GetPixelF write SetPixelF;
       property PixelT :GLenum    read GetPixelT write SetPixelT;
       ///// メソッド
       procedure Bind;
       procedure Unbind;
       procedure Use( const BindI_:GLuint );
       procedure Unuse( const BindI_:GLuint );
       procedure SendData; virtual; abstract;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager1D<_TPixel_>

     IGLImager1D = interface( IGLImager )
     ['{9802F2EE-57A9-4E2E-AE7F-CCC6A32DC3FE}']
       ///// アクセス
       function GetTexelsX :Integer;
       procedure SetTexelsX( const TexelsX_:Integer );
       ///// プロパティ
       property TexelsX :Integer read GetTexelsX write SetTexelsX;
     end;

     //-------------------------------------------------------------------------

     TGLImager1D<_TPixel_:record> = class( TGLImager, IGLImager1D )
     private
     protected
       _Texels :TBricArray1D<_TPixel_>;
       ///// アクセス
       function GetTexels( const X_:Integer ) :_TPixel_;
       procedure SetTexels( const X_:Integer; const Texel_:_TPixel_ );
       function GetTexelsX :Integer;
       procedure SetTexelsX( const TexelsX_:Integer );
     public
       constructor Create; overload;
       constructor Create( const TexelsX_:Integer ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Texels[ const X_:Integer ] :_TPixel_ read GetTexels  write SetTexels ; default;
       property TexelsX                    :Integer  read GetTexelsX write SetTexelsX;
       ///// メソッド
       procedure SendData; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager2D<_TPixel_>

     IGLImager2D = interface( IGLImager )
     ['{FE12BAB0-3DF5-4D47-B97E-7BC1059557F3}']
       ///// アクセス
       function GetTexelsX :Integer;
       procedure SetTexelsX( const TexelsX_:Integer );
       function GetTexelsY :Integer;
       procedure SetTexelsY( const TexelsX_:Integer );
       ///// プロパティ
       property TexelsX :Integer read GetTexelsX write SetTexelsX;
       property TexelsY :Integer read GetTexelsY write SetTexelsY;
     end;

     //-------------------------------------------------------------------------

     TGLImager2D<_TPixel_:record> = class( TGLImager, IGLImager2D )
     private
     protected
       _Texels :TBricArray2D<_TPixel_>;
       ///// アクセス
       function GetTexels( const X_,Y_:Integer ) :_TPixel_;
       procedure SetTexels( const X_,Y_:Integer; const Texel_:_TPixel_ );
       function GetTexelsX :Integer;
       procedure SetTexelsX( const TexelsX_:Integer );
       function GetTexelsY :Integer;
       procedure SetTexelsY( const TexelsY_:Integer );
     public
       constructor Create; overload;
       constructor Create( const TexelsX_,TexelsY_:Integer ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Texels[ const X_,Y_:Integer ] :_TPixel_ read GetTexels  write SetTexels ; default;
       property TexelsX                       :Integer  read GetTexelsX write SetTexelsX;
       property TexelsY                       :Integer  read GetTexelsY write SetTexelsY;
       ///// メソッド
       procedure SendData; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager3D<_TPixel_>

     IGLImager3D = interface( IGLImager )
     ['{9901BFAD-086D-4BC7-A870-56DB2A7A2BD0}']
       ///// アクセス
       ///// プロパティ
     end;

     //-------------------------------------------------------------------------

     TGLImager3D<_TTexel_:record;_TTexels_:constructor,TArray3D<_TTexel_>> = class( TGLImager, IGLImager3D )
     private
     protected
       _Texels :_TTexels_;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Texels :_TTexels_ read _Texels;
       ///// メソッド
       procedure SendData; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D<_TPixel_>

     TGLBricer3D<_TTexel_:record> = class( TGLImager3D<_TTexel_,TBricArray3D<_TTexel_>> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D<_TPixel_>

     TGLGrider3D<_TTexel_:record> = class( TGLImager3D<_TTexel_,TGridArray3D<_TTexel_>> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLSample

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TGLSample.GetWrapU :GLint;
begin
     Result := _WrapU;
end;

procedure TGLSample.SetWrapU( const WrapU_:GLint );
begin
     _WrapU := WrapU_;

     SetParamI( GL_TEXTURE_WRAP_S, _WrapU );
end;

function TGLSample.GetWrapV :GLint;
begin
     Result := _WrapV;
end;

procedure TGLSample.SetWrapV( const WrapV_:GLint );
begin
     _WrapV := WrapV_;

     SetParamI( GL_TEXTURE_WRAP_T, _WrapV );
end;

function TGLSample.GetWrapW :GLint;
begin
     Result := _WrapW;
end;

procedure TGLSample.SetWrapW( const WrapW_:GLint );
begin
     _WrapW := WrapW_;

     SetParamI( GL_TEXTURE_WRAP_R, _WrapW );
end;

//------------------------------------------------------------------------------

function TGLSample.GetMinFilter :GLint;
begin
     Result := _MinFilter;
end;

procedure TGLSample.SetMinFilter( const MinFilter_:GLint );
begin
     _MinFilter := MinFilter_;

     SetParamI( GL_TEXTURE_MIN_FILTER, _MinFilter );
end;

function TGLSample.GetMagFilter :GLint;
begin
     Result := _MagFilter;
end;

procedure TGLSample.SetMagFilter( const MagFilter_:GLint );
begin
     _MagFilter := MagFilter_;

     SetParamI( GL_TEXTURE_MAG_FILTER, _MagFilter );
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLSample.SetParamI( const Name_:GLenum; const Value_:GLint );
begin
     glSamplerParameteri( _ID, Name_, Value_ );
end;

procedure TGLSample.SetParamF( const Name_:GLenum; const Value_:GLfloat );
begin
     glSamplerParameterf( _ID, Name_, Value_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLSample.Create;
begin
     inherited;

     glGenSamplers( 1, @_ID );

     WrapU     := GL_CLAMP_TO_EDGE;
     WrapV     := GL_CLAMP_TO_EDGE;
     WrapW     := GL_CLAMP_TO_EDGE;
     MinFilter := GL_LINEAR;
     MagFilter := GL_LINEAR;
end;

destructor TGLSample.Destroy;
begin
     glDeleteSamplers( 1, @_ID );

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLSample.Use( const BindI_:GLuint );
begin
     glBindSampler( BindI_, _ID );
end;

procedure TGLSample.Unuse( const BindI_:GLuint );
begin
     glBindSampler( BindI_, 0 );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TGLImager.GetKind :GLenum;
begin
     Result := _Kind;
end;

procedure TGLImager.SetKind( const Kind_:GLenum );
begin
     _Kind := Kind_;
end;

function TGLImager.GetTexelF :GLenum;
begin
     Result := _TexelF;
end;

procedure TGLImager.SetTexelF( const TexelF_:GLenum );
begin
     _TexelF := TexelF_;
end;

function TGLImager.GetPixelF :GLenum;
begin
     Result := _PixelF;
end;

procedure TGLImager.SetPixelF( const PixelF_:GLenum );
begin
     _PixelF := PixelF_;
end;

function TGLImager.GetPixelT :GLenum;
begin
     Result := _PixelT;
end;

procedure TGLImager.SetPixelT( const PixelT_:GLenum );
begin
     _PixelT := PixelT_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager.Create( const Kind_:GLenum );
begin
     inherited Create;

     _Field := TGLSample.Create;

     glGenTextures( 1, @_ID );

     _Kind   := Kind_;
     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;

     Bind;
       glTexParameteri( _Kind, GL_TEXTURE_MAX_LEVEL, 0 );
     Unbind;
end;

destructor TGLImager.Destroy;
begin
     glDeleteTextures( 1, @_ID );

     _Field.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager.Bind;
begin
     glBindTexture( _Kind, _ID );
end;

procedure TGLImager.Unbind;
begin
     glBindTexture( _Kind, 0 );
end;

//------------------------------------------------------------------------------

procedure TGLImager.Use( const BindI_:GLuint );
begin
     //_Field.Use( BindI_ );

     glActiveTexture( GL_TEXTURE0 + BindI_ );

       Bind;

     glActiveTexture( GL_TEXTURE0 );
end;

procedure TGLImager.Unuse( const BindI_:GLuint );
begin
     glActiveTexture( GL_TEXTURE0 + BindI_ );

       Unbind;

     glActiveTexture( GL_TEXTURE0 );

     //_Field.Unuse( BindI_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager1D<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TGLImager1D<_TPixel_>.GetTexels( const X_:Integer ) :_TPixel_;
begin
     Result := _Texels[ X_ ];
end;

procedure TGLImager1D<_TPixel_>.SetTexels( const X_:Integer; const Texel_:_TPixel_ );
begin
     _Texels[ X_ ] := Texel_;
end;

//------------------------------------------------------------------------------

function TGLImager1D<_TPixel_>.GetTexelsX :Integer;
begin
     Result := _Texels.BricsX;
end;

procedure TGLImager1D<_TPixel_>.SetTexelsX( const TexelsX_:Integer );
begin
     _Texels.BricsX := TexelsX_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager1D<_TPixel_>.Create;
begin
     Create( 0 );
end;

constructor TGLImager1D<_TPixel_>.Create( const TexelsX_:Integer );
begin
     inherited Create( GL_TEXTURE_1D );

     _Texels := TBricArray1D<_TPixel_>.Create( TexelsX_ );
end;

destructor TGLImager1D<_TPixel_>.Destroy;
begin
     _Texels.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager1D<_TPixel_>.SendData;
begin
     Bind;
       glTexImage1D( _Kind, 0, _TexelF, _Texels.BricsX, 0,
                               _PixelF,
                               _PixelT,
                               _Texels.ItemP[ 0 ] );
     Unbind;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager2D<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TGLImager2D<_TPixel_>.GetTexels( const X_,Y_:Integer ) :_TPixel_;
begin
     Result := _Texels[ X_, Y_ ];
end;

procedure TGLImager2D<_TPixel_>.SetTexels( const X_,Y_:Integer; const Texel_:_TPixel_ );
begin
     _Texels[ X_, Y_ ] := Texel_;
end;

//------------------------------------------------------------------------------

function TGLImager2D<_TPixel_>.GetTexelsX :Integer;
begin
     Result := _Texels.BricsX;
end;

procedure TGLImager2D<_TPixel_>.SetTexelsX( const TexelsX_:Integer );
begin
     _Texels.BricsX := TexelsX_;
end;

function TGLImager2D<_TPixel_>.GetTexelsY :Integer;
begin
     Result := _Texels.BricsY;
end;

procedure TGLImager2D<_TPixel_>.SetTexelsY( const TexelsY_:Integer );
begin
     _Texels.BricsY := TexelsY_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager2D<_TPixel_>.Create;
begin
     Create( 0, 0 );
end;

constructor TGLImager2D<_TPixel_>.Create( const TexelsX_,TexelsY_:Integer );
begin
     inherited Create( GL_TEXTURE_2D );

     _Texels := TBricArray2D<_TPixel_>.Create( TexelsX_, TexelsY_ );
end;

destructor TGLImager2D<_TPixel_>.Destroy;
begin
     _Texels.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager2D<_TPixel_>.SendData;
begin
     Bind;
       glTexImage2D( _Kind, 0, _TexelF, _Texels.BricsX,
                                        _Texels.BricsY, 0,
                               _PixelF,
                               _PixelT,
                               _Texels.ItemP[ 0, 0 ] );
     Unbind;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager3D<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager3D<_TTexel_,_TTexels_>.Create;
begin
     inherited Create( GL_TEXTURE_3D );

     _TexelF := GL_R32F;
     _PixelF := GL_RED;
     _PixelT := GL_FLOAT;

     _Texels := _TTexels_.Create;

     _Texels.MargsX := 1;
     _Texels.MargsY := 1;
     _Texels.MargsZ := 1;
end;

destructor TGLImager3D<_TTexel_,_TTexels_>.Destroy;
begin
     _Texels.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager3D<_TTexel_,_TTexels_>.SendData;
begin
     Bind;
       glTexImage3D( _Kind, 0, _TexelF, _Texels.ElemsX,
                                        _Texels.ElemsY,
                                        _Texels.ElemsZ, 0,
                               _PixelF,
                               _PixelT,
                               _Texels.ElemsP0 );
     Unbind;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLBricer3D<_TTexel_>.Create;
begin
     inherited;

     with _Field do
     begin
          WrapU := GL_MIRRORED_REPEAT;
          WrapV := GL_MIRRORED_REPEAT;
          WrapW := GL_MIRRORED_REPEAT;
     end;
end;

destructor TGLBricer3D<_TTexel_>.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D<_TPixel_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLGrider3D<_TTexel_>.Create;
begin
     inherited;

     with _Field do
     begin
          WrapU := GL_CLAMP_TO_EDGE;
          WrapV := GL_CLAMP_TO_EDGE;
          WrapW := GL_CLAMP_TO_EDGE;
     end;
end;

destructor TGLGrider3D<_TTexel_>.Destroy;
begin

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■