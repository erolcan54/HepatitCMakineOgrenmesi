import pickle

modelLG=pickle.load(open("KNNModelSon.sav","rb"))

from flask import Flask, request
app=Flask(__name__)
@app.route("/tahmin",methods=["POST"])
def tahmin():
    #request_data=request.get_json(force=True)

    ALT_MAP=request.json["ALT_MAP"]
    AST_MAP=request.json["AST_MAP"]
    ALP_MAP=request.json["ALP_MAP"]
    ALB_MAP=request.json["ALB_MAP"]
    BIL_MAP=request.json["BIL_MAP"]
    PROT_MAP=request.json["PROT_MAP"]
    GGT_MAP=request.json["GGT_MAP"]
    CREA_MAP=request.json["CREA_MAP"]
    CHOL_MAP=request.json["CHOL_MAP"]
    CHE_MAP=request.json["CHE_MAP"]
    sonuc=modelLG.predict([[ALT_MAP,AST_MAP,ALP_MAP,ALB_MAP,BIL_MAP,PROT_MAP,GGT_MAP,CREA_MAP,CHOL_MAP,CHE_MAP]])
    
    return str(int(sonuc))

app.run()