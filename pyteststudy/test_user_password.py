import pytest
import json

users = json.loads(open('./users.dev.json', 'r').read())


class TestUserPassword(object):
    @pytest.fixture(params=users)      #fixtures参数化
    def user(self, request):
        return request.param

    def test_user_password(self, user):
        # 遍历每条user数据
        passwd = user['password']
        assert len(passwd) >= 6
        msg = "user {0} has a weak password".format(user['name'])
        assert passwd != 'password', msg
        assert passwd != 'password123', msg
