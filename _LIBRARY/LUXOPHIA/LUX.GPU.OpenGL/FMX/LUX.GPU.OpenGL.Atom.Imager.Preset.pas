unit LUX.GPU.OpenGL.Atom.Imager.Preset;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX, LUX.GPU.OpenGL.Atom.Imager;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager1D_RGBA

     TGLImager1D_RGBA = class( TGLImager1D<TAlphaColorF> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
       ///// メソッド
       procedure ImportFrom( const BMP_:TBitmap );
       procedure ExportTo( const BMP_:TBitmap );
       procedure LoadFromFile( const FileName_:String );
       procedure SaveToFile( const FileName_:String );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager2D_RGBA

     TGLImager2D_RGBA = class( TGLImager2D<TAlphaColorF> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
       ///// メソッド
       procedure ImportFrom( const BMP_:TBitmap );
       procedure ExportTo( const BMP_:TBitmap );
       procedure LoadFromFile( const FileName_:String );
       procedure SaveToFile( const FileName_:String );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D_AlphaColorF

     TGLBricer3D_AlphaColorF = class( TGLBricer3D<TAlphaColorF> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D_AlphaColorF

     TGLGrider3D_AlphaColorF = class( TGLGrider3D<TAlphaColorF> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D_AlphaColorF

     TGLBricer3D_Single = class( TGLBricer3D<Single> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D_AlphaColorF

     TGLGrider3D_Single = class( TGLGrider3D<Single> )
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

uses Winapi.OpenGL, Winapi.OpenGLext;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager1D_RGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager1D_RGBA.Create;
begin
     inherited;

     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;
end;

destructor TGLImager1D_RGBA.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager1D_RGBA.ImportFrom( const BMP_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     TexelsX := BMP_.Width;

     BMP_.Map( TMapAccess.Read, B );

     for X := 0 to TexelsX-1 do
     begin
          Texels[ X ] := TAlphaColorF.Create( B.GetPixel( X, 0 ) );
     end;

     BMP_.Unmap( B );

     SendData;
end;

procedure TGLImager1D_RGBA.ExportTo( const BMP_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     BMP_.SetSize( TexelsX, 1 );

     BMP_.Map( TMapAccess.Write, B );

     for X := 0 to TexelsX-1 do
     begin
          B.SetPixel( X, 0, Texels[ X ].ToAlphaColor );
     end;

     BMP_.Unmap( B );
end;

//------------------------------------------------------------------------------

procedure TGLImager1D_RGBA.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     ImportFrom( B );

     B.DisposeOf;
end;

procedure TGLImager1D_RGBA.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     ExportTo( B );

     B.SaveToFile( FileName_ );

     B.DisposeOf;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLImager2D_RGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLImager2D_RGBA.Create;
begin
     inherited;

     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;
end;

destructor TGLImager2D_RGBA.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLImager2D_RGBA.ImportFrom( const BMP_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     TexelsX := BMP_.Width ;
     TexelsY := BMP_.Height;

     BMP_.Map( TMapAccess.Read, B );

     for Y := 0 to TexelsY-1 do
     begin
          for X := 0 to TexelsX-1 do
          begin
               Texels[ X, Y ] := TAlphaColorF.Create( B.GetPixel( X, Y ) );
          end;
     end;

     BMP_.Unmap( B );

     SendData;
end;

procedure TGLImager2D_RGBA.ExportTo( const BMP_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     BMP_.SetSize( TexelsX, TexelsY );

     BMP_.Map( TMapAccess.Write, B );

     for Y := 0 to TexelsY-1 do
     begin
          for X := 0 to TexelsX-1 do
          begin
               B.SetPixel( X, Y, Texels[ X, Y ].ToAlphaColor );
          end;
     end;

     BMP_.Unmap( B );
end;

//------------------------------------------------------------------------------

procedure TGLImager2D_RGBA.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     ImportFrom( B );

     B.DisposeOf;
end;

procedure TGLImager2D_RGBA.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     ExportTo( B );

     B.SaveToFile( FileName_ );

     B.DisposeOf;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D_RGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLBricer3D_AlphaColorF.Create;
begin
     inherited;

     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;
end;

destructor TGLBricer3D_AlphaColorF.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D_RGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLGrider3D_AlphaColorF.Create;
begin
     inherited;

     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;
end;

destructor TGLGrider3D_AlphaColorF.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer3D_RGBA

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLBricer3D_Single.Create;
begin
     inherited;

     _TexelF := GL_R32F;
     _PixelF := GL_RED;
     _PixelT := GL_FLOAT;
end;

destructor TGLBricer3D_Single.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLGrider3D_Single

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLGrider3D_Single.Create;
begin
     inherited;

     _TexelF := GL_R32F;
     _PixelF := GL_RED;
     _PixelT := GL_FLOAT;
end;

destructor TGLGrider3D_Single.Destroy;
begin

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■