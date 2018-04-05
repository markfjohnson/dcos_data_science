

from kafka import KafkaProducer
import time

kafka_url = ["kafka-0-broker.kafka.autoip.dcos.thisdcos.directory:1025","kafka-1-broker.kafka.autoip.dcos.thisdcos.directory:1025", "kafka-2-broker.kafka.autoip.dcos.thisdcos.directory:1025"]
topic_name = "example_topic"

p = KafkaProducer(bootstrap_servers=kafka_url,api_version=(0,10))

iter_count = 0

while True:
    msg = b"test message - {}".format(iter_count)
    print msg
    p.send(topic_name, msg)
    time.sleep(1)
    iter_count = iter_count + 1

