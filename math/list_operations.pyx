from . conversion cimport toMatrix4
from . cimport transformVec3AsPoint_InPlace, distanceVec3, mixVec3, multMatrix4, setIdentityMatrix4


cpdef void transformVector3DListAsPoints(Vector3DList vectors, matrix):
    cdef:
        Matrix4 _matrix
        Vector3* _vectors

    toMatrix4(&_matrix, matrix)
    _vectors = <Vector3*>vectors.base.data
    transformVector3DListAsPoints_LowLevel(_vectors, vectors.getLength(), &_matrix)

cdef void transformVector3DListAsPoints_LowLevel(Vector3* vectors, long arrayLength, Matrix4* matrix):
    cdef long i
    for i in range(arrayLength):
        transformVec3AsPoint_InPlace(vectors + i, matrix)

cpdef double distanceSumOfVector3DList(Vector3DList vectors):
    cdef:
        Vector3* _vectors = <Vector3*>vectors.base.data
        double distance = 0
        long i

    for i in range(vectors.getLength() - 1):
        distance += distanceVec3(_vectors + i, _vectors + i + 1)
    return distance

cdef void mixVec3Arrays(Vector3* target, Vector3* a, Vector3* b, long arrayLength, float factor):
    cdef long i
    for i in range(arrayLength):
        mixVec3(target + i, a + i, b + i, factor)

cdef void reduceMatrix4x4List(Matrix4* matrices, unsigned long amount, Matrix4* target):
    cdef:
        long i
        Matrix4 tmp

    if amount == 0:
        setIdentityMatrix4(target)
    elif amount == 1:
        target[0] = matrices[0]
    else:
        tmp = matrices[0]
        for i in range(1, amount):
            multMatrix4(target, &tmp, matrices + i)
            tmp = target[0]
