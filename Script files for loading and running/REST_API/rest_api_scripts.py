


from flask import Flask, request
from flask_restful import Resource, Api
from sqlalchemy import create_engine
from json import dumps
import psycopg2
import os
SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://w205:MIDS@localhost/littlesis"
e = create_engine(SQLALCHEMY_DATABASE_URI)
app = Flask(__name__)
api = Api(app)
#**************************
class TopSchools(Resource):
  def get(self):      
      conn = e.connect()
      query = conn.execute("SELECT name FROM aatopschools;")
      result = {"top schools": [i[0] for i in query.cursor.fetchall()]}
      return result

class Donations(Resource):
  def get(self, topschoolorgradid):
      topschoolorgradid = topschoolorgradid.replace('_', ' ')
      conn = e.connect()
      if topschoolorgradid.upper() == "ALL":
        query = conn.execute("SELECT ent1, gradid, topschool, reltype, relamt, politican, party, startdate FROM aadonbytopgrads order by relamt desc limit 10;")
        result = {"Donations": [{"1) grad":i[0], "2) grad id":str(i[1]),  "3) school":i[2], "4) type":i[3], "5) amount":str(i[4]), "6) to person":i[5], "7) party":i[6], "8) year":i[7]}   for i in query.cursor.fetchall()]}
      elif topschoolorgradid.isdigit():
	topschoolorgradid = int(topschoolorgradid)
	print type(topschoolorgradid)
	query = conn.execute("SELECT ent1, entid1, ent2, entid2, reltype, relamt FROM aaentrel where reltype = 'Donation' and entid1 = %d limit 10; " % topschoolorgradid)  
        result = {"Donations": [{"1) entity 1":i[0], "2) grad id":str(i[1]),  "3) donated to":i[2], "4) id of recipient":str(i[3]), "5) relation type":i[4], "6) Amount":str(i[5]) }   for i in query.cursor.fetchall()]}
	print 'set result'
      else:
        query = conn.execute("SELECT ent1, gradid, topschool, reltype, relamt, politican, party, startdate FROM aadonbytopgrads WHERE topschool = '%s' order by relamt desc limit 10;" % topschoolorgradid)
        result = {"Donations": [{"1) grad":i[0], "2) grad id":str(i[1]),  "3) school":i[2], "4) type":i[3], "5) amount":str(i[4]), "6) to person":i[5], "7) party":i[6], "8) year":i[7]}   for i in query.cursor.fetchall()]}
      print result
      return result

class IndividualConnections(Resource):
  def get(self, gradid):
      conn = e.connect()
      if gradid == "0":
	  print 'got into ALL statement'
      else:
          gradid = int(gradid)
          query = conn.execute("select ent1, entid1, ent2, entid2, reltype from aaentrel where reltype != 'Donation' and entid1 = %d limit 10; " % gradid)
      result = {"Connections": [{"1) entity 1":i[0], "2) entity 1 id":str(i[1]),  "3) entity 2":i[2], "4) entity 2 id ":str(i[3]), "5) relation type":i[4]}   for i in query.cursor.fetchall()]}
      return result


class DonationSummaries(Resource):
    def get(self, topschool, year):
        print topschool 
        topschool = topschool.replace('_', ' ')
        conn = e.connect()
        if topschool.upper() == "ALL":
            if year.upper() == "ALL":
                query = conn.execute('''select startdate,
                    round(SUM(case when  party = 'Democratic Party' then relamt else 0 end)/sum(relamt), 2) as dem_percent,
                    round(SUM(case when  party = 'Republican Party' then relamt else 0 end) / sum(relamt), 2) as rep_percent,
                    SUM(relamt) as total_amount
                    from aadonbytopgrads
                    group by startdate order by startdate desc;''')
                result = {"Summary of political contributions": [{"1) Year":i[0], "2) Democrat %":str(i[1]),  "3) Republican %":str(i[2]), "4) Total $":str(i[3])}  for i in query.cursor.fetchall()]}
            else: #specific year
                year = int(year)
                query = conn.execute('''select startdate, 
                    round(SUM(case when  party = 'Democratic Party' then relamt else 0 end)/sum(relamt), 2) as dem_percent,
                    round(SUM(case when  party = 'Republican Party' then relamt else 0 end) / sum(relamt), 2) as rep_percent,
                    SUM(relamt) as total_amount
                    from aadonbytopgrads
                    where startdate = '%s'
                    group by startdate;''', (year) )
                result = {"Summary of political contributions": [{"1) Year":i[0], "2) Democrat %":str(i[1]),  "3) Republican %":str(i[2]), "4) Total $":str(i[3])}  for i in query.cursor.fetchall()]}
        else: #specific top school
            if year.upper() == "ALL":
                query = conn.execute('''select startdate,
                    round(SUM(case when  party = 'Democratic Party' then relamt else 0 end)/sum(relamt), 2) as dem_percent,
                    round(SUM(case when  party = 'Republican Party' then relamt else 0 end) / sum(relamt), 2) as rep_percent,
                    SUM(relamt) as total_amount
                    from aadonbytopgrads
                    where topschool = '%s'
                    group by startdate order by startdate desc ;''' % topschool)
                result = {"Summary of political contributions": [{"1) Year":i[0], "2) Democrat %":str(i[1]),  "3) Republican %":str(i[2]), "4) Total $":str(i[3])}  for i in query.cursor.fetchall()]}
            else: #specific year
                year = int(year)
		print topschool
		print '+++++++++++++++++before query', year
		query = conn.execute('''select * from aadonbytopgrads 
		    limit 10;''')
		print '++++++++++++++++completed first query'
		print type(year) 

                query = conn.execute('''select startdate, 
                    round(SUM(case when  party = 'Democratic Party' then relamt else 0 end)/sum(relamt), 2) as dem_percent,
                    round(SUM(case when  party = 'Republican Party' then relamt else 0 end) / sum(relamt), 2) as rep_percent,
                    SUM(relamt) as total_amount
                    from aadonbytopgrads
                    where topschool = '%s' and
                    startdate = '%s'
                    group by startdate ;''' % (topschool, year) )

		print '+++++++++++++++++ completed query'
                result = {"Summary of political contributions": [{"1) Year":i[0], "2) Democrat %":str(i[1]),  "3) Republican %":str(i[2]), "4) Total $":str(i[3])}  for i in query.cursor.fetchall()]}
        return result


api.add_resource(DonationSummaries, "/donationsummaries/<string:topschool>/<string:year>")
api.add_resource(TopSchools, "/topschools")
api.add_resource(Donations, "/donations/<string:topschoolorgradid>")
api.add_resource(IndividualConnections, "/connections/<string:gradid>")

if __name__ == '__main__':
    test_con = e.connect()
    test_query = "SELECT * FROM aapoltypes LIMIT 5;"
    test_result = test_con.execute(test_query)
    print test_result.cursor.fetchall()
    port = int(os.environ.get("PORT", 8080))
    app.run(host='0.0.0.0', port=port, debug=True)

