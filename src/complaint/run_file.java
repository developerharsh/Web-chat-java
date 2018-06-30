package complaint;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


import org.hibernate.*;
import org.hibernate.cfg.*;

public class run_file
{
    public static void main(String[] args) 
    {
        Configuration cfg=new Configuration();
        cfg.configure("Hibernate.cfg.xml");
        System.out.println("Loaded Configuration .........");
        
        SessionFactory sf=cfg.buildSessionFactory();
        System.out.println("Loaded SessionFactory ..........");
        
        Session s=sf.openSession();
        System.out.println("Loaded Session ..........");
        
        String type="New Requirement";
        complaint_model p = new complaint_model();
        	p.setType(type);
        	p.setAttachments("abc.jsp");
        	p.setCurrently_assigned(1001);
        	SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
            String time = localDateFormat.format(new Date());
    			//System.out.println(time);
    		       System.out.println(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
        	p.setDateTime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
        	p.setModule("IT");
        	p.setPriority("low");
        	p.setStatus("new");
        	p.setSubject("welcome");
        	p.setType("bug");
        	p.setUserId(10001);
        	s.save(p);
        
        Transaction t = s.beginTransaction();
    	t.commit();

//        Query q= s.createSQLQuery("select datetime from complaint");
//        List l = q.list();
//        Iterator it = l.iterator();
//        while(it.hasNext())
//        {
//        	Object st = (Object)it.next();
//        	System.out.println(st);
//        }
        System.out.println("Loaded Transaction .........");
        
        s.close();
        sf.close();
    }
    
}
