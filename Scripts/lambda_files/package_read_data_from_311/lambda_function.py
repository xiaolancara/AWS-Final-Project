import pandas as pd
from sodapy import Socrata
import datetime
import json


def lambda_handler(event, context):
    client = Socrata('data.cityofnewyork.us',
                 'Tarfn2kl2IdBRX1RkC5rhcoOh',
                 timeout = 150
                )
    Previous_twoday = str(datetime.datetime.today() - datetime.timedelta(days=2))[:19]
    Previous_twoday = Previous_twoday[:10] + 'T' + Previous_twoday[11:]
    Previous_oneday = str(datetime.datetime.today() - datetime.timedelta(days=1))[:19]
    Previous_oneday = Previous_oneday[:10] + 'T' + Previous_oneday[11:]
    response = client.get("erm2-nwe9", where="created_date BETWEEN '"+Previous_twoday+"' AND '"+Previous_oneday+"'", limit=10000)
    results_df = pd.DataFrame.from_records(response)
    client.close()
    print('Successfully getting create time from \'{}\' to \'{}\''.format(Previous_twoday, Previous_oneday))
