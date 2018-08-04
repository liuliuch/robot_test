import time
import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By



class TestBaiDu(unittest.TestCase):
    URL ='http://www.baidu.com'
    Step= 1
    locator_kw = (By.ID, 'kw')
    locator_su = (By.ID, 'su')
    locator_result = (By.XPATH, '//div[contains(@class, "result")]/h3/a')
    driver = webdriver.Chrome()

    def setUp(self):

        if self.Step==1:
            self.driver.get(self.URL)
            self.driver.maximize_window()
        else:
            js = 'window.open("http://www.baidu.com");'
            self.driver.execute_script(js)


    def tearDown(self):
        print("-----------")

    def test_search_0(self):
        self.driver.find_element(*self.locator_kw).send_keys('selenium 灰蓝')
        self.driver.find_element(*self.locator_su).click()
        time.sleep(2)
        links = self.driver.find_elements(*self.locator_result)
        for link in links:
            print(link.text)
        self.Step=0

    def test_search_1(self):
        self.driver.find_element(*self.locator_kw).send_keys('Python selenium')
        self.driver.find_element(*self.locator_su).click()
        time.sleep(2)
        links = self.driver.find_elements(*self.locator_result)
        for link in links:
            print(link.text)


if __name__ == '__main__':
    unittest.main()