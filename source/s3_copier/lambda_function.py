import os
import logging


logLevel = os.getenv("LOG_LEVEL", "ERROR").upper()
log      = logging.getLogger()
log.setLevel(logLevel)


def lambda_handler(event, context):
    log.debug(event)
