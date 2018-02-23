#version 430

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%【共通定数】

layout( std140 ) uniform TViewerScal
{
  layout( row_major ) mat4 _ViewerScal;
};

layout( std140 ) uniform TCameraProj
{
  layout( row_major ) mat4 _CameraProj;
};

layout( std140 ) uniform TCameraPose
{
  layout( row_major ) mat4 _CameraPose;
};

layout( std140 ) uniform TShaperPose
{
  layout( row_major ) mat4 _ShaperPose;
};

//------------------------------------------------------------------------------

uniform sampler3D _Voxels;

uniform sampler2D _Imager;

//############################################################################## ■

out TSenderVG
{
  ivec3 Pos;
}
_Result;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

void main()
{
  const ivec3 _VoxelsN = textureSize( _Voxels, 0 ) - ivec3( 1 );
  const int   SZ        = _VoxelsN.y * _VoxelsN.x;
  const int   SY        =              _VoxelsN.x;
  const int   I         = gl_VertexID;

  ivec3 B;
  int   J;

  B.z = I / SZ;  J   = I - SZ * B.z;
  B.y = J / SY;  B.x = J - SY * B.y;

  _Result.Pos = B;
}

//############################################################################## ■
