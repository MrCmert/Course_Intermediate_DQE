import time

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options


# Set up Chrome options for incognito mode
chrome_options = Options()
chrome_options.add_argument("--incognito")

# Launch Chrome browser in incognito mode
driver = webdriver.Chrome(options=chrome_options)

# Open the website
driver.get("https://ssn.trainings.dlabanalytics.com/")

unprotected_page_1 = driver.find_element(By.ID, 'details-button')
unprotected_page_1.click()

unprotected_page_2 = driver.find_element(By.ID, 'proceed-link')
unprotected_page_2.click()

time.sleep(7)
# Click on 'EPAM SSO' button
epam_sso_button = driver.find_element(By.ID, 'social-epam-idp')


epam_sso_button.click()


time.sleep(3)

# Write email in text field
email_field = driver.find_element(By.NAME, 'loginfmt')
email_field.send_keys("Vitalii_Stetsenko@epam.com")

time.sleep(2)
# Click on 'Next' button
next_button = driver.find_element(By.ID, "idSIButton9")
next_button.click()

time.sleep(2)
# Write password in text field
password_field = driver.find_element(By.NAME, 'passwd')
password_field.send_keys("password")

time.sleep(2)

next_button_2 = driver.find_element(By.ID, "idSIButton9")
next_button_2.click()

# Wait for 30 seconds
time.sleep(30)

# Check status field
status_of_env = driver.find_element(By.CSS_SELECTOR, "td.status-col.status")
status = status_of_env.text.strip()
if status == 'Stopped':
    button_actions = driver.find_element(By.CSS_SELECTOR, "span.actions")
    button_actions.click()
    button_start = driver.find_element(By.CSS_SELECTOR, "div.ng-tns-c13-1")
    button_start.click()
    time.sleep(120)
    driver.refresh()


env_options = driver.find_element(By.CSS_SELECTOR, "span.mat-tooltip-trigger.ng-tns-c13-1.ng-star-inserted")
env_options.click()

link_to_jupyter = driver.find_element(By.CSS_SELECTOR, "a.ellipsis.none-select.resources-url.mat-tooltip-trigger")
link_to_jupyter.click()


driver.switch_to.window(driver.window_handles[-1])
time.sleep(5)
unprotected_page_3 = driver.find_element(By.ID, 'details-button')
unprotected_page_3.click()

time.sleep(2)
unprotected_page_4 = driver.find_element(By.ID, 'proceed-link')
unprotected_page_4.click()

# notebook opened
time.sleep(5)
item_name = "DQ_Checks_vstetsenko.ipynb"
xpath_expression = f"//span[@class='item_name' and text()='{item_name}']"
find_notebook = driver.find_element(By.XPATH, xpath_expression)
find_notebook.click()

driver.switch_to.window(driver.window_handles[-1])


time.sleep(5)
run_notebook = driver.find_element(By.CSS_SELECTOR, 'i.fa-forward.fa')
run_notebook.click()
time.sleep(2)
confirm_run = driver.find_element(By.CSS_SELECTOR, 'button.btn.btn-default.btn-sm.btn-danger')
confirm_run.click()

time.sleep(60)

driver.quit()
