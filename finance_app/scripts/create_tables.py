import random
import string
import datetime
import pandas as pd
import numpy as np
from faker import Faker
fake = Faker()

Faker.seed(1)
random.seed(1)

def company(size):
    df = pd.DataFrame()
    df['id'] = [str(i+1) for i in range (size)]
    df['industry'] = np.random.choice(['Oil & Gas', 'Banks Regional', 'Biotechnology', 'Asset Management', np.nan], size)
    df['sector'] = np.random.choice(['Technology', 'Industrials', 'Energy', 'Financial Services', 'Real Estate', np.nan], size)
    df['active'] = [fake.boolean(chance_of_getting_true=63) for i in range(size)]    
    df['price'] = np.random.uniform(low=0.1, high=2.6, size=(df.shape[0],))
    df['comment'] = [fake.sentence(nb_words=60) for i in range (size)]
    return df

def stocks(size):
    df = pd.DataFrame()
    df['id'] = [str(i+1) for i in range(size)]
    df['currency'] = [fake.currency_code() for i in range(size)]
    df['date'] = [fake.date() for i in range (size)]
    df['open'] = np.random.randint(1, 24000, size=df.shape[0])
    df['high'] = np.random.randint(1, 24000, size=df.shape[0])
    df['low'] = np.random.randint(1, 24000, size=df.shape[0])
    df['close'] = np.random.randint(1, 24000, size=df.shape[0])
    df['active'] = [fake.boolean(chance_of_getting_true=63) for i in range(size)]
    return df
    

# Create company table
company_df = company(4000)
# Store it in csv
company_df.to_csv('./finance_app/data/company.csv', index=False)

# Create stock table
stocks_df = stocks(4000)
stocks_df['date'] = pd.to_datetime(stocks_df['date'])

# Store it in csv
stocks_df.to_csv('./finance_app/data/stocks.csv', index=False)