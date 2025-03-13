'''
    
'''

import subprocess, time

time_threshold = 10


'''

'''
def run_test(app, file, m, n):
    st = time.perf_counter()
    p = subprocess.run([app, file, m, n], shell=True, capture_output=True)
    nd = time.perf_counter() - st
    return p, nd


'''

'''
def test_cheap(bin, filename, m, n):
    py = [0]
    while py[len(py)-1] < time_threshold:
        print(f'Attempting {m}, {n}')
        t1 = run_test(bin, filename, str(m), str(n))
        if t1[0].returncode != 0:
            print('FAIL!', t1)
            f1 = time.strftime('%H:%M:%S:%S.%f', time.gmtime(py[-1]))
            f2 = time.strftime('%H:%M:%S:%S.%f', time.gmtime(t1[1]))
            print(f'Highest 2 were: \n \
                  {m} , {n-1} {f1} \
                  {m}, {n} at {f2}s')
            break
        if t1[1] > 1:
            n = n*2
        else:
            n = n*10
        py.append(t1[1])
        print(time.strftime('%H:%M:%S', time.gmtime(t1[1])))
        #time.sleep(1)


'''

'''
def run_cmd(bin, filename, m, n):
    ret = [0]
    while ret[len(ret)-1] < time_threshold:
        print(f'Attempting {filename} {m} {n}')
        st = time.perf_counter()
        p = subprocess.run([bin, filename, m, n], 
                           shell=True, capture_output=True, text=True)
        nd = time.perf_counter() - st
        if p.returncode != 0:
            print('FAIL!', p)
            break
        print(p.stdout, time.strftime('%H:%M:%S', time.gmtime(nd)))
        ret.append(nd)
        n = str(int(n) + 1)
    print('Done\n')



if __name__ == '__main__':
    '''
        Python tests
    '''
    # Default version of python
    p = subprocess.run(['python3', '-V'], shell=True, capture_output=True)
    if p.returncode != 0:
        print('No default python')
    else:
        #run_cmd('python3', 'python\\ack.py', '3', '8')
        #run_cmd('python3', 'python\\ackmem.py', '3', '8')
        #run_cmd('python3', 'python\\stackermann.py', '3', '8')
        #run_cmd('python3', 'python\\acksthread.py', '3', '8')
        #run_cmd('python3', 'python\\memthread.py', '3', '18')
        #test_cheap('python3', 'python\\acksnq.py', 3, 10000)
        #test_cheap('python3', 'python\\ackcheap.py', 3, 10000)
        try:
            #import numba
            #print('Running JIT')
            #run_cmd('python3', 'python\\ackJIT.py', 3, 10)
            #run_cmd('python3', 'python\\acksJIT.py', 3, 12)
            pass
        except ModuleNotFoundError:
            print('numba module not found, run "pip install numba"')
    
    '''
        Batch tests
    '''
    #run_cmd('cmd/c', 'batch\\recursive\\ack.cmd', '3', '0')
    #run_cmd('cmd/c', 'batch\\mem\\mem.cmd', '3', '3')
    
    # Max n is 28
    #p = subprocess.run(['batch\\ackcheap.cmd', '3', '28'], shell=True, capture_output=True)
    #if int(p.stdout.decode()) != 2147483645:
    #    print('FAIL!', p)
    
    #run_cmd('cmd/c', 'batch\\acks.cmd', '3', '3')

    '''
        Powershell tests
    '''
    # Check for powershell 7
    #p = subprocess.run(['pwsh', '-V'], shell=True, capture_output=True)
    #if p.returncode == 0:
        #run_cmd('pwsh', 'powershell\\ackr.ps1', '3', '3')
        #run_cmd('pwsh', 'powershell\\acks.ps1', '3', '3')
        #run_cmd('pwsh', 'powershell\\ackmem.ps1', '3', '3')
        #run_cmd('pwsh', 'powershell\\ackcheap.ps1', '3', '3500000')
    #else:
        #run_cmd('powershell', 'powershell\\ackr.ps1', '3', '3')
        #run_cmd('powershell', 'powershell\\acks.ps1', '3', '3')
        #run_cmd('powershell', 'powershell\\ackmem.ps1', '3', '6')
        #run_cmd('powershell', 'powershell\\ackcheap.ps1', '3', '3000000')

    '''
        C tests
    '''
    p = subprocess.run(['gcc'])
    if p.returncode != 0:
        print('gcc is not installed')
    else:
        # Compile
        p = subprocess.run(['gcc'])
    
        



