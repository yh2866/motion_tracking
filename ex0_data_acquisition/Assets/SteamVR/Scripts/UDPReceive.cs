
/*
 
    -----------------------
    UDP-Receive (send to)
    -----------------------
    // [url]http://msdn.microsoft.com/de-de/library/bb979228.aspx#ID0E3BAC[/url]
   
   
    // > receive
    // 127.0.0.1 : 8051
   
    // send
    // nc -u 127.0.0.1 8051
 
*/
using UnityEngine;
using System.Collections;

using System;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;

public class UDPReceive : MonoBehaviour {
	
	// receiving Thread
	Thread receiveThread;
	
	// udpclient object
	UdpClient client;
	
	// public
	// public string IP = "127.0.0.1"; default local
	public int port; // define > init
	
	// infos
	public string lastReceivedUDPPacket="";
	public string allReceivedUDPPackets=""; // clean up this from time to time!
	private InformationParser infoParser;

	private bool connectionStarted; 
	private volatile bool keepReciving; 


	
	// start from shell
	private static void Main()
	{
		UDPReceive receiveObj=new UDPReceive();
		receiveObj.init();
		
		string text="";
		do
		{
			text = Console.ReadLine();
		}
		while(!text.Equals("exit"));
	}
	// start from unity3d
	public void Start()
	{
		connectionStarted = true; //changed to true due to below
		keepReciving = true; 
		init ();		//added so that connection starts on play

	}
	
	// OnGUI
	void OnGUI()
	{
		Rect rectObj=new Rect(40,10,200,400);
		GUIStyle style = new GUIStyle();
		style.alignment = TextAnchor.UpperLeft;
		GUI.Box(rectObj,"# UDPReceive\n127.0.0.1 "+port+" #\n"
		        + "shell> nc -u 127.0.0.1 : "+port+" \n"
		        + "\nLast Packet: \n"+ lastReceivedUDPPacket
		        ,style);


		if (connectionStarted == false) {
			if (GUI.Button (new Rect (20, 10, 80, 20), "Connect")) {
				keepReciving = true;
				init ();
				connectionStarted = true;
			}
		} else {

			if (GUI.Button (new Rect (20, 10, 80, 20), "Disconnect")) {
				keepReciving = false; 
				connectionStarted = false;
				client.Close();
				receiveThread.Join();
			}

		}

	}
	
	// init
	private void init()
	{
		infoParser = gameObject.AddComponent<InformationParser> ();
		//print("UDPSend.init()");
		
		// define port
		port = 12345;
		
		// status
		//print("Sending to 127.0.0.1 : "+port);
		//print("Test-Sending to this Port: nc -u 127.0.0.1  "+port+"");

		receiveThread = new Thread(
			new ThreadStart(ReceiveData));
		receiveThread.IsBackground = true;
		receiveThread.Start();

		//SendData ();
		
	}
	
	// receive thread
	private  void ReceiveData()
	{

		client = new UdpClient(port);
		while (keepReciving)
		{
			try
			{
				IPEndPoint anyIP = new IPEndPoint(IPAddress.Any, 0);
				byte[] data = client.Receive(ref anyIP);
				
				// Bytes mit der UTF8-Kodierung in das Textformat kodieren.
				string text = Encoding.UTF8.GetString(data);
				
				// Den abgerufenen Text anzeigen.
				//print(">> " + text);
				
				// latest UDPpacket
				lastReceivedUDPPacket=text;
				infoParser.parseStringFromTCP(lastReceivedUDPPacket);
				
				// ....
				allReceivedUDPPackets=allReceivedUDPPackets+text;
				
			}
			catch (Exception err)
			{
				print(err.ToString());
			}
		}
	}

	// getLatestUDPPacket
	// cleans up the rest 
	public string getLatestUDPPacket()
	{
		allReceivedUDPPackets="";
		return lastReceivedUDPPacket;
	}
}
