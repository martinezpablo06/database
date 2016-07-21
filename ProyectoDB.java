//Para compilar escribir: javac ProyectoDB.java
//Para ejecutar escribir: java -cp ".:postgresql-9.0-801.jdbc4.jar" ProyectoDB

import java.sql.*;
import java.io.*;

public class ProyectoDB {
	
	public static void main(String[] args) {
    
	    try {
	      String driver = "org.postgresql.Driver";
	      String url = "jdbc:postgresql://localhost:5432/proyectoDB";
	      String username = "postgres";
	      String password = "root";
	      
	      //carga el driver de la base de datos si no se cargó.
	      Class.forName(driver);
	      
	      //establece la conección de red a la base de datos.
	      Connection connection =
	    	        DriverManager.getConnection(url, username, password);
	      
	      
	      /* TODO EL CODIGO VA ACA */
	      /* TODO EL CODIGO VA ACA */
          
          //codigo para leer desde consola  
	      try{
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

            System.out.println("Nombre de programa:");
        	String sNombre_prog = br.readLine();
        	System.out.println("Descripcion de programa:");
        	String sDescr_prog = br.readLine();

            System.out.println("Ingrese los siguientes datos de la persona");
            System.out.println("DNI:");
        	String sDNI = br.readLine();
            System.out.println("NOMBRE:");
        	String sNombre = br.readLine();
        	System.out.println("APELLIDO:");
        	String sApellido = br.readLine();
        	System.out.println("DIRECCIÓN:");
        	String sDirec = br.readLine();
        	System.out.println("EMAIL (Opcional):");
        	String sEmail = br.readLine();
        	System.out.println("FACEBOOK (Opcional):");
        	String sFace = br.readLine();
        	System.out.println("TELÉFONO FIJO (Opcional):");
        	String sTFijo = br.readLine();
        	System.out.println("TELEFONO MOVIL (Opcional):");
        	String sTMovil = br.readLine();
        	System.out.println("FECHA DE NACIMIENTO:");
        	String sNac = br.readLine();
        	System.out.println("EDAD:");
        	String sEdad = br.readLine();
        	System.out.println("CÓDIGO POSTAL");
        	String sCP = br.readLine();

        	System.out.println("Ingrese un medio de pago:");
        	String sMPago = br.readLine();
		    
        	String query1 = "insert into proyecto.programa values(?,?)";

     		PreparedStatement stn1 = connection.prepareStatement(query1);
      
      		stn1.setString(1,sNombre_prog);
      		stn1.setString(2,sDescr_prog);
      		stn1.executeUpdate();

        	String query3 = "insert into proyecto.MedioDePago values(?)";

     		PreparedStatement stn3 = connection.prepareStatement(query3);
      
      		stn3.setString(1,sMPago);
      		stn3.executeUpdate();

        	String query2 = "insert into proyecto.persona values(?,?,?,?,?,?,?,?,?,?,?)";

     		PreparedStatement stn2 = connection.prepareStatement(query2);
      
      		stn2.setString(1,sDNI);
      		stn2.setString(2,sNombre);
      		stn2.setString(3,sApellido);
      		stn2.setString(4,sDirec);
      		stn2.setString(5,sEmail);
      		stn2.setString(6,sFace);
      		stn2.setString(7,sTFijo);
      		stn2.setString(8,sTMovil);
      		stn2.setString(9,sNac);
      		stn2.setString(10,sEdad);
      		stn2.setString(11,sCP);
      		stn2.executeUpdate();
          
			
      		

      		/*String query = "insert into proyecto.programa (nombre,descripcion) values(?,?)";

     		PreparedStatement statement = connection.prepareStatement(query);
      
      		stn2.setString(1,sNombre);
      		stn2.setString(2,sDescripcion);
      		stn2.executeUpdate();

      		String query = "insert into proyecto.programa (nombre,descripcion) values(?,?)";

     		PreparedStatement statement = connection.prepareStatement(query);
      
      		stn2.setString(1,sNombre);
      		stn2.setString(2,sDescripcion);
      		stn2.executeUpdate();
          */
      	  } catch(Exception e) {
      	  }
  
	      /* TODO EL CODIGO VA ACA */
	      /* TODO EL CODIGO VA ACA */
	      
	    }
	    
	    catch(ClassNotFoundException cnfe) {
	        System.err.println("Error loading driver: " + cnfe);
	    } 
	    
	    catch(SQLException sqle) {
	        sqle.printStackTrace();
	        System.err.println("Error connecting: " + sqle);
	    }      
	}
}
