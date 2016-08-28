from . cimport Vector3

cdef struct Matrix4:
    float a11, a12, a13, a14
    float a21, a22, a23, a24
    float a31, a32, a33, a34
    float a41, a42, a43, a44

cdef void transformVec3AsPoint_InPlace(Vector3* vector, Matrix4* matrix)
cdef void transformVec3AsPoint(Vector3* target, Vector3* vector, Matrix4* matrix)

cdef void setIdentityMatrix4(Matrix4* m)
cdef void setTranslationMatrix4(Matrix4* m, Vector3* v)

cdef void multMatrix4(Matrix4* target, Matrix4* x, Matrix4* y)
