unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.TabControl,
  LUX, LUX.D1, LUX.D2, LUX.D3, LUX.M4,
  LUX.GPU.OpenGL,
  LUX.GPU.OpenGL.Viewer,
  LUX.GPU.OpenGL.Atom.Shader,
  LUX.GPU.OpenGL.Scener,
  LUX.GPU.OpenGL.Camera,
  LUX.GPU.OpenGL.Shaper,
  LUX.GPU.OpenGL.Matery,
  LUX.GPU.OpenGL.Matery.Imager.Preset;

type
  TForm1 = class(TForm)
          GLViewer1: TGLViewer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GLViewer1DblClick(Sender: TObject);
    procedure GLViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { private 宣言 }
    _MouseA :TSingle2D;
    _MouseS :TShiftState;
    _MouseP :TSingle2D;
  public
    { public 宣言 }
    _Scener  :TGLScener;
    _Camera1 :TGLCameraPers;
    _Matery  :TGLMateryImagG;
    _Shaper  :TGLShaperPrimPoin;
    ///// メソッド
    procedure MakeCamera;
    procedure MakeMatery;
    procedure MakeShaper;
    procedure MakeVoxels( const Angle_:Single );
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.MakeCamera;
begin
     _Camera1 := TGLCameraPers.Create( _Scener );

     with _Camera1 do
     begin
          Angl := DegToRad( 60{°} );

          Pose := TSingleM4.RotateX( DegToRad( -45 ) )
                * TSingleM4.Translate( 0, 0, +2 );
     end;

     GLViewer1.Camera := _Camera1;
end;

//------------------------------------------------------------------------------

function Pãodering( const P_:TPoint3D ) :Single;
var
   X2, Y2, Z2, A :Single;
begin
     X2 := Sqr( P_.X );
     Y2 := Sqr( P_.Y );
     Z2 := Sqr( P_.Z );

     A := Abs( Sqr( ( X2 - Y2 ) / ( X2 + Y2 ) ) - 0.5 );

     Result := Sqr( Sqrt( X2 + Y2 ) - 8 - A ) + Z2 - Sqr( 2 + 3 * A );
end;

procedure TForm1.MakeVoxels( const Angle_:Single );
var
   X, Y, Z :Integer;
   P, P2 :TPoint3D;
begin
     with _Matery do
     begin
          for Z := 0 to _Voxels.TexelsZ-1 do
          begin
               P.Z := 24 * ( Z / (_Voxels.TexelsZ-1) - 0.5 );

               for Y := 0 to _Voxels.TexelsY-1 do
               begin
                    P.Y := 24 * ( Y / (_Voxels.TexelsY-1) - 0.5 );

                    for X := 0 to _Voxels.TexelsX-1 do
                    begin
                         P.X := 24 * ( X / (_Voxels.TexelsX-1) - 0.5 );

                         P2 := P * TMatrix3D.CreateRotationX( DegToRad( Angle_ ) );

                         _Voxels[ X, Y, Z ] := Pãodering( P2 );
                    end;
               end;
          end;

          _Voxels.SendData;
     end;
end;

procedure TForm1.MakeMatery;
var
   X, Y, Z :Integer;
begin
     _Matery := TGLMateryImagG.Create;

     with _Matery do
     begin
          with ShaderV do
          begin
               Source.LoadFromFile( '..\..\_DATA\ShaderV.glsl' );

               Assert( Status, Errors.Text );
          end;

          with ShaderG do
          begin
               Source.LoadFromFile( '..\..\_DATA\ShaderG.glsl' );

               Assert( Status, Errors.Text );
          end;

          with ShaderF do
          begin
               Source.LoadFromFile( '..\..\_DATA\ShaderF.glsl' );

               Assert( Status, Errors.Text );
          end;

          with Engine do
          begin
               with Verters do
               begin
                    Del( 0{BinP} );
                    Del( 1{BinP} );
                    Del( 2{BinP} );
               end;

               Assert( Status, Errors.Text );
          end;

          with Imager do
          begin
               LoadFromFile( '..\..\_DATA\Spherical_2048x1024.png' );
          end;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.MakeShaper;
begin
     _Shaper := TGLShaperPrimPoin.Create( _Scener );

     with _Shaper do
     begin
          Matery := _Matery;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Scener := TGLScener.Create;

     MakeCamera;
     MakeMatery;
     MakeShaper;

     MakeVoxels( 0 );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Scener.DisposeOf;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.GLViewer1DblClick(Sender: TObject);
begin
     with GLViewer1.MakeScreenShot do
     begin
          SaveToFile( 'Viewer1.png' );

          DisposeOF;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.GLViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TSingle2D.Create( X, Y );
end;

procedure TForm1.GLViewer1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TSingle2D;
begin
     if ssLeft in _MouseS then
     begin
          P := TSingle2D.Create( X, Y );

          _MouseA := _MouseA + ( P - _MouseP );

          _Shaper.Pose := TSingleM4.RotateX( DegToRad( _MouseA.Y ) )
                        * TSingleM4.RotateY( DegToRad( _MouseA.X ) );

          GLViewer1.Repaint;

          _MouseP := P;
     end;
end;

procedure TForm1.GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     GLViewer1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

end. //######################################################################### ■
