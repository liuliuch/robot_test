import requests

class TestV2exApi(object):
    domain = 'https://www.v2ex.com/'

    def test_node(self):
        path = 'api/nodes/show.json?name=python'
        url = self.domain + path
        res = requests.get(url).json()
        print(res)
        assert res['id'] == 90
        assert res['name'] == 'python'