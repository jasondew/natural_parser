String whereClause = "depSubscriberSsn = '" + his350a1.getSsn() + "'"
        + " AND "
        + "depSsn = '" + his350a1.getDepSsn[i] + "'";   
ArrayList<Dep> depRecords = Dep.find(1, whereClause);
for(Dep dep : depRecords)
{
    if(depRecords.size() == 0)
    {
        studentCertReq = true;
        continue;
    }                     
    else
    {
        if(dep.getDepEligibility().startsWith("2"))
        {
            studentCertReq = false;
        }
        else
        {
                        studentCertReq = true;
        }
       
    }

    origDepEligibility = dep.getDepEligibility();
}
