import hashlib

def md5_py(str):
    '''
    生成MD5
    :return:
    '''
    m = hashlib.md5()
    m.update(str.encode("utf8"))
    print(m.hexdigest())
    return m.hexdigest()