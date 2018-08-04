import requests
import pytest

class TestV2exApi(object):
    domain = 'https://www.v2ex.com/'

    @pytest.fixture(params=["python","java","go","nodejs"])
    def name(self,request):  #必须是request
        return request.param

    def test_node(self,name):
        path = 'api/nodes/show.json?name={0}'.format(name)
        url = self.domain + path
        res = requests.get(url).json()
        print(res)

        assert res['name'] == name