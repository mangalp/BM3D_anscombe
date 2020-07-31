import os
pathsA=['p0','p1','p2','p3','p4']
pathsB=['o0','o1','o2','o3','o4']
for a in pathsA:
    for b in pathsB:
        target='./Zeiss/'+a+'/orientations/'+b+'/'
        source='./simcare/mpi-cluster/batchTrain-n2v-mpicluster.sh'
        command='cp '+source + ' '+target
        print(command)
        os.system(command)
        
        command='module load cuda/9.0.176; '
        command=command+'cd '+target + '; sbatch batchTrain-n2v-mpicluster.sh'
        print(command)
        os.system(command)
        
