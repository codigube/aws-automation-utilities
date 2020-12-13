#!/usr/bin/env python

import click
import boto3

@click.command()
@click.option('--keyword', prompt='The keyword for bucket name',
              help='The keyword used for searching buckets to delete.')
def run(keyword):
    s3 = boto3.resource('s3')

    for bucket in s3.buckets.all():
        if keyword in bucket.name:
            print("Deleting bucket:" + bucket.name)
            # This is required to delete bucket with versioning enabled
            bucket.object_versions.delete()
            bucket.delete()

if __name__ == '__main__':
    run()




