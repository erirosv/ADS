# libraries
import json
import time
import requests
from bs4 import BeautifulSoup

# base info for scraping
base_url = 'https://jobb.blocket.se'
path = '/lediga-jobb-i-goteborg'
pages = 10

# methods
def get_html(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "html.parser")
    return soup


def get_details(url):
    soup = get_html(url)
    description = soup.find(class_='description').text
    skills = []
    if (soup.find(class_='skills-list')):
        skills = soup.find(
            class_='skills-list').text.strip().replace('/ /g', '').split('\n')

    return [description, skills]


def get_jobs(url):
    print('start: ' + url)
    data = []
    soup = get_html(url)
    jobs = soup.find_all(class_='job-item')
    for job in jobs:
        description = job.find(class_='description').text.strip()

        # time.sleep(1)

        # details_link = job.find(
        #     'a', class_='job-result-card__block-link')['href']
        # details = get_details(base_url + details_link)

        data.append({
            'description': description,
        })
        print(jobs.index(job) + 1, 'of', len(jobs), 'done')
    return data


data = [] # init list for data
for i in range(1, pages + 1):
    url = base_url + path + '?pageno=' + str(i)
    data += get_jobs(url)
    with open('data.json', 'w') as outfile:
        json.dump(data, outfile)
