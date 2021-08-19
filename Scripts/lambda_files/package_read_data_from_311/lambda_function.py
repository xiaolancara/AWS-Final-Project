import pandas as pd
from sodapy import Socrata
import datetime
import boto3
import s3fs
import io
import json
from botocore.errorfactory import ClientError

def lambda_handler(event, context):
    client = Socrata('data.cityofnewyork.us',
                     'Tarfn2kl2IdBRX1RkC5rhcoOh',
                     timeout=150
                     )
    Previous_twoday = str(datetime.datetime.today() - datetime.timedelta(days=2))[:19]
    Previous_twoday = Previous_twoday[:10] + 'T' + Previous_twoday[11:]
    Previous_oneday = str(datetime.datetime.today() - datetime.timedelta(days=1))[:19]
    Previous_oneday = Previous_oneday[:10] + 'T' + Previous_oneday[11:]
    response = client.get("erm2-nwe9",
                          where="created_date BETWEEN '" + Previous_twoday + "' AND '" + Previous_oneday + "'",
                          limit=10000)
    results_df = pd.DataFrame.from_records(response)
    client.close()
    print('Successfully getting create time from \'{}\' to \'{}\''.format(Previous_twoday, Previous_oneday))

    s3 = boto3.client('s3')
    try:
        file_name = "311_service_request/latest_service_request.csv"
        # check if the csv file exist in s3 bucket
        # get the existing file
        obj = s3.get_object(Bucket='ia-final-project-bucket', Key=file_name)
        df_current = pd.read_csv(io.BytesIO(obj['Body'].read()), index_col=0)
        current_data = df_current.to_csv(None, index=False).encode()
        # append
        bytes_to_write = results_df.to_csv(None, header=None, index=False).encode()
        appended_data = current_data + bytes_to_write
        # overwrite
        s3.put_object(Body=appended_data, Bucket='ia-final-project-bucket', Key=file_name)
        return 'Successfully found existing file and appended data to {}'.format(file_name)

    except ClientError:
        # Not found
        pathname = 'ia-final-project-bucket/'  # specify location of s3:/{my-bucket}/
        filenames = pathname + file_name  # name of the filepath and csv file
        byte_encoded_df = results_df.to_csv(None, index=False).encode()  # encodes file as binary
        s3 = s3fs.S3FileSystem(anon=False)
        with s3.open(filenames, 'wb') as file:
            file.write(byte_encoded_df)  # writes byte-encoded file to s3 location
        return "Successfull created and uploaded file to location:" + str(filenames)



