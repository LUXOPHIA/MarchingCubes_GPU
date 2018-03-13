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
  LUX.GPU.OpenGL.Scener,
  LUX.GPU.OpenGL.Camera,
  LUX.GPU.OpenGL.Render,
  LUX.GPU.OpenGL.Shaper.Preset.TMarcubes;

type
  TForm1 = class(TForm)
    GLViewer1: TGLViewer;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GLViewer1DblClick(Sender: TObject);
    procedure GLViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { private 宣言 }
    _MouseA :TSingle2D;
    _MouseS :TShiftState;
    _MouseP :TSingle2D;
  public
    { public 宣言 }
    _Scener :TGLScener;
    _Camera :TGLCameraPers;
    _Shaper :TMarcubes;
    ///// メソッド
    procedure MakeCamera;
    procedure MoveCamera;
    procedure MakeVoxels;
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
     _Camera := TGLCameraPers.Create( _Scener );

     with _Camera do
     begin
          Angl := DegToRad( 60{°} );
     end;

     GLViewer1.Camera := _Camera;

     _MouseA := TPointF.Create( -30, +30 );

     MoveCamera;
end;

procedure TForm1.MoveCamera;
begin
     with _Camera do
     begin
          Pose := TSingleM4.RotateY( DegToRad( -_MouseA.X ) )
                * TSingleM4.RotateX( DegToRad( -_MouseA.Y ) )
                * TSingleM4.Translate( 0, 0, 2 );
     end;
end;

//------------------------------------------------------------------------------

function Pãodering( const P_:TSingle3D ) :Single;
var
   X2, Y2, Z2, A :Single;
begin
     X2 := Pow2( P_.X );
     Y2 := Pow2( P_.Y );
     Z2 := Pow2( P_.Z );

     A := Abs( Pow2( ( X2 - Y2 ) / ( X2 + Y2 ) ) - 0.5 );

     Result := Pow2( Roo2( X2 + Y2 ) - 8 - A ) + Z2 - Pow2( 2 + 3 * A );
end;

procedure TForm1.MakeVoxels;
var
   X, Y, Z :Integer;
   P :TSingle3D;
begin
     with _Shaper do
     begin
          with Grider.Texels do
          begin
               //    -1   0  +1  +2  +3  +4
               //  -1 +---+---+---+---+---+
               //     |///|///|///|///|///|
               //   0 +---*---*---*---*---+
               //     |///| 1 | 2 | 3 |///|  BricsX = 3 = GridsX-1
               //  +1 +---*---*---*---*---+
               //     |///|   |   |   |///|
               //  +2 +---*---*---*---*---+
               //     |///|   |   |   |///|
               //  +3 +---*---*---*---*---+
               //     |///|///|///|///|///|
               //  +4 +---+---+---+---+---+
               //         1   2   3   4      GridsX = 4 = BricsX+1

               for Z := -1 to GridsZ do
               begin
                    P.Z := 24 * ( Z / BricsZ - 0.5 );

                    for Y := -1 to GridsY do
                    begin
                         P.Y := 24 * ( Y / BricsY - 0.5 );

                         for X := -1 to GridsX do
                         begin
                              P.X := 24 * ( X / BricsX - 0.5 );

                              Grids[ X, Y, Z ] := Pãodering( P );
                         end;
                    end;
               end;
          end;

          MakeModel;  //ポリゴンモデル生成
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Scener := TGLScener.Create;

     MakeCamera;

     _Shaper := TMarcubes.Create( _Scener );

     with _Shaper do
     begin
          SizeX := 2.4;
          SizeY := 2.4;
          SizeZ := 2.4;

          with Grider.Texels do
          begin
               BricsX := 64;
               BricsY := 64;
               BricsZ := 64;
          end;

          Matery := TMarcubesMateryFacesMIR.Create;

          with Matery as TMarcubesMateryFacesMIR do
          begin
               Imager.LoadFromFile( '..\..\_DATA\Spherical_2048x1024.png' );
          end;

          IsShowCubes := True;
     end;

     MakeVoxels;

     ScrollBar1Change( Sender )
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

          MoveCamera;

          GLViewer1.Repaint;

          _MouseP := P;
     end;
end;

procedure TForm1.GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     GLViewer1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

//------------------------------------------------------------------------------

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
     _Shaper.Threshold := ScrollBar1.Value;

     GLViewer1.Repaint;
end;

end. //######################################################################### ■
