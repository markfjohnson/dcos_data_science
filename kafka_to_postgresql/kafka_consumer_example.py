from kafka import KafkaConsumer

print("Start of Kafka consumer program")
kafka_url = "broker.kafka.l4lb.thisdcos.directory:9092"
#kafka_url = "localhost:9092"

topic_name = "example_topic"

print("Connecting to {}".format(kafka_url))
consumer = KafkaConsumer(topic_name, bootstrap_servers=kafka_url,
                         group_id="PrimaryGroup",
                         enable_auto_commit=True,
                         api_version=(0,10))
print ('Start consuming')
for message in consumer:
    print(message)
print("Done consuming")
