from bs4 import BeautifulSoup
import requests as rq
import pandas as pd

newsLines = pd.DataFrame()

url = 'https://it.hse.ru'

page = rq.get(url)
parse = BeautifulSoup(page.text, features="html.parser")

headers = []
for x in parse.findAll('div', class_='plate_news__title'):
    headers.append(x.text)
newsLines['Headers'] = headers

links = []
for x in parse.findAll('a', class_='link_dark2', href=True):
    links.append(x['href'])
newsLines['Links'] = links

someText = []
for x in parse.findAll('div', class_='plate_news__text'):
    someText.append(x.text)
newsLines['More'] = someText

date = []
for x in parse.findAll('div', class_='plate_news__date'):
    date.append(x.text)
newsLines['Date'] = date

print(newsLines)

with open("vyschka_news.txt", "w") as file:
    file.write(newsLines.to_csv())
