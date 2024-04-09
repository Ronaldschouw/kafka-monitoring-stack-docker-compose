#!/usr/bin/python3

import random
import ssl
import logging
import sys
import time
from datetime import datetime
from kafka import KafkaProducer


def enable_debug_logs():
    logger = logging.getLogger('kafka')
    logger.addHandler(logging.StreamHandler(sys.stdout))
    logger.setLevel(logging.DEBUG)

def produce_eneco_pt():
    #certificate_directory_path = '/home/ronald/ptest'
    topic = 'donderdag'
    kafka_brokers = '127.0.0.1:9091'
    #cert_location = f'{certificate_directory_path}/ca.crt'
    #key_location = f'{certificate_directory_path}/ca.key'
    #context = ssl.create_default_context()
    #context.load_cert_chain(certfile=cert_location, keyfile=key_location)
    #context.check_hostname = False
    #context.verify_mode = ssl.CERT_NONE
    producer = KafkaProducer(bootstrap_servers=kafka_brokers)

    print(f"Number of partitions = {producer.partitions_for(topic)}")
    print(f"Connected = {producer.bootstrap_connected()}")
    #for i in range(0, 10_000_000):
    for i in range(0, 100):
        message = f'Message {i} from Ronald_DHL_Remote {datetime.now()}'
        print(message)
        producer.send(topic, key=bytes(str(random.randint(0, 100)), 'utf-8'),
                      value=bytes(message, 'utf-8'))
        time.sleep(2)
    producer.flush()
    producer.close(1000)


if __name__ == "__main__":
    #enable_debug_logs()
    produce_eneco_pt()
