'''
creates confound files based on fmriprep output
usage: python3 confounds.py <path/to/fmriprep/directory> <path/to/derivatives>
Caleb Haynes Winter 2020 - built off Jeff Denison's MakeConfounds.py script
'''
import os
import glob
import sys
import numpy as np
import pandas as pd


cons = glob.glob(sys.argv[1] + '**/*confounds*.tsv', recursive=True)


for f in cons:
    
    file_data =  f.split('/')
    
    subno = file_data[-3]
    file_name = file_data[-1]
    path = sys.argv[2] + 'fsl/confounds/' + file_name

    df = pd.read_csv(f,sep='\t')

    csf_wm =['csf','white_matter']
    cosine = [col for col in df if col.startswith('cosine')]
    nss = [col for col in df if col.startswith('non_steady_state')]
    aroma_motion=[col for col in df if col.startswith('aroma')]
    
    filter_col=np.concatenate([csf_wm, cosine, nss, aroma_motion])

    
    df_all = df[filter_col]

    
    if not os.path.exists(path):
        os.makedirs(path)
    
    df_all.to_csv(index=False,sep='\t',header=False)

    
