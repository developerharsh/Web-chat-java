package generator;


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
       
        
        gen_model p = new gen_model();
        	p.setNumber(10000);
        	s.save(p);
        
        Transaction t = s.beginTransaction();
    	t.commit();

        System.out.println("Loaded Transaction .........");
        
        s.close();
        sf.close();
    }
    
}

