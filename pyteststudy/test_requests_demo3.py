# python, id=90
# java, id=63
# nodejs, id=436
# go, id=375

import requests
import pytest

class TestV2exApi(object):
    domain = 'https://www.v2ex.com/'

    @pytest.mark.parametrize('name,node_id',[('python',90),('java',63),('go',375),('nodejs',436)])
    def test_node(self,name,node_id):
        path = 'api/nodes/show.json?name={0}'.format(name)
        url = self.domain + path
        res = requests.get(url).json()
        #print(res)

        assert res['name'] == name
        assert res['id'] == node_id

