import os
import sys
import csv 
import bagit
import pprint as pp


csvpath = 'csvs/sip-bagging.csv'

def parseCSV(csvPath):
    with open(csvPath, 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        csvDict = {}
        for row in reader:
            csvDict[row['SIP_ID']] = {'id':row['Identifier'], 'transcription':row['Transcription']}
    return csvDict

#bagging function for individual bag
def makeBag(directoryPath, csvDict):
    #get identifier from pathname
    identifier = os.path.basename(directoryPath)
    #query CSV for object using identifier and store in value
    carrier = csvDict[identifier]
    #use ke/value notation to extract the original ID and transcription from the carrier object
    dID = carrier['id']
    transcript = carrier['transcription']
    #create bag using metadata harvested
    bag = bagit.make_bag(directoryPath, {'External-Identifier': dID, 'External-Description': transcript})
    #rename to reflect the creation of the SIP
    os.rename(directoryPath, directoryPath+"_SIP")
    return bag    

#main function
def main(baseDirStr):
    myDictionary = parseCSV('csvs/sip-bagging.csv')
    for dir in os.listdir(baseDirStr):
        dirPath = baseDirStr + "/" + dir
        if os.path.isdir(dirPath):
            if dir.endswith("_SIP"):
                print(f"{dir} appears to already have been bagged, continuing to next directory.")
                continue
            else:
                makeBag(dirPath, myDictionary)
        else:
            continue

main('/home/bcadmin/Desktop/SIPs')

#loop through directory
#extract directory name
#feed into bagging function
