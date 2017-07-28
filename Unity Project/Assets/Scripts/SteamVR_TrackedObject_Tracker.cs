//======= Copyright (c) Valve Corporation, All rights reserved. ===============
//
// Purpose: For controlling in-game objects with tracked devices.
//
//=============================================================================

using UnityEngine;
using Valve.VR;
using System;
using System.Collections;
using System.IO;
using System.Linq;
// using System.Collections;
//using Fromatter;
//using System.Fromatter;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.InteropServices;

public class HighResolutionDateTime
{
    public static bool IsAvailable { get; private set; }

    [DllImport("Kernel32.dll", CallingConvention = CallingConvention.Winapi)]
    private static extern void GetSystemTimePreciseAsFileTime(out long filetime);

    public static DateTime UtcNow
    {
        get
        {
            if (!IsAvailable)
            {
                throw new InvalidOperationException(
                    "High resolution clock isn't available.");
            }

            long filetime;
            GetSystemTimePreciseAsFileTime(out filetime);

            return DateTime.FromFileTimeUtc(filetime);
        }
    }

    static HighResolutionDateTime()
    {
        try
        {
            long filetime;
            GetSystemTimePreciseAsFileTime(out filetime);
            IsAvailable = true;
        }
        catch (EntryPointNotFoundException)
        {
            // Not running Windows 8 or higher.
            IsAvailable = false;
        }
    }
}


public class SteamVR_TrackedObject_Tracker : MonoBehaviour
{
	public enum EIndex
	{
		None = -1,
		Hmd = (int)OpenVR.k_unTrackedDeviceIndex_Hmd,
		Device1,
		Device2,
		Device3,
		Device4,
		Device5,
		Device6,
		Device7,
		Device8,
		Device9,
		Device10,
		Device11,
		Device12,
		Device13,
		Device14,
		Device15
	}

	public EIndex index;
	public Transform origin; // if not set, relative to parent
    public bool isValid = false;
    public bool Start_Flag = false;
    public ArrayList myArrayList = new ArrayList();

    public DateTime Time_Pre;


    UDPSend sendObj = new UDPSend();
    //UDPReceive receiveObj = new UDPReceive();



    void OnGUI()
    {

    	if(GUI.Button(new Rect(10,100,100,30),"Start"))
    	{
    		Debug.Log("Start");
    		Start_Flag = true;
    		// Debug.Log(System.DateTime.Now.Ticks/TimeSpan.TicksPerMillisecond);
    		// Debug.Log(System.DateTime.Now);
    		// Debug.Log(System.DateTime.UtcNow);
    		// Debug.Log(Time.deltaTime);
    		//Debug.Log(System.DateTime.Now.Ticks);
    		//DateTime myDate = new DateTime(System.DateTime.Now.Ticks);
    		//HighResolutionDateTime myDate = new HighResolutionDateTime();
    		var precise_time = HighResolutionDateTime.UtcNow;
    		Debug.Log(precise_time);
    		TimeSpan diff = HighResolutionDateTime.UtcNow - Time_Pre;
    		Debug.Log(diff);
    		//Time_Pre = HighResolutionDateTime.UtcNow;
    	}

    	if(GUI.Button(new Rect(10,140,100,30),"End"))
    	{

    		Debug.Log("End");
    		Save_Data();
    	}
    }


	void Save_Data()
	{
		// BinaryFormatter bf = new BinaryFormatter();
		// FileStream file = File.Create(Application.persistentDataPath + "myArrayList.dat");

		// Debug.Log(Application.persistentDataPath);


		// bf.Serialize(file, myArrayList);
		// file.Close();
		File.WriteAllLines(Application.persistentDataPath + "myArrayList.txt",myArrayList.Cast<string>().ToArray());
	}

// [Serializable]
// class LocalData
// 	{
// 		public string pos_x;
// 		public string pos_y;
// 		public string pos_z;
// 		public string rot_x;
// 		public string rot_y;
// 		public string rot_z;
// 		public string rot_w;

// 	}

    private void OnNewPoses(TrackedDevicePose_t[] poses)
	{
		if (index == EIndex.None)
			return;

		var i = (int)index;

        isValid = false;
		if (poses.Length <= i)
			return;

		if (!poses[i].bDeviceIsConnected)
			return;

		if (!poses[i].bPoseIsValid)
			return;

        isValid = true;

		var pose = new SteamVR_Utils.RigidTransform(poses[i].mDeviceToAbsoluteTracking);

		if (origin != null)
		{
			transform.position = origin.transform.TransformPoint(pose.pos);
			transform.rotation = origin.rotation * pose.rot;
            //Debug.Log("Print out position"+ transform.position.x);
            //sendObj.sendString(transform.position.x.ToString());
        }
		else
		{
			transform.localPosition = pose.pos;
			transform.localRotation = pose.rot;

			//LocalData data = new LocalData();

			// data.pos_x = transform.localPosition.x.ToString();
			// data.pos_y = transform.localPosition.y.ToString();
			// data.pos_z = transform.localPosition.z.ToString();
			// data.rot_x = transform.localRotation.x.ToString();
			// data.rot_y = transform.localRotation.y.ToString();
			// data.rot_z = transform.localRotation.z.ToString();
			// data.rot_w = transform.localRotation.w.ToString();
			if(Start_Flag == true)
			{
				TimeSpan diff = HighResolutionDateTime.UtcNow - Time_Pre;
				myArrayList.Add(HighResolutionDateTime.UtcNow.ToString());
				myArrayList.Add(diff.ToString());
				myArrayList.Add(transform.localPosition.x.ToString());
				myArrayList.Add(transform.localPosition.y.ToString());
				myArrayList.Add(transform.localPosition.z.ToString());
				myArrayList.Add(transform.localRotation.x.ToString());
				myArrayList.Add(transform.localRotation.y.ToString());
				myArrayList.Add(transform.localRotation.z.ToString());
				myArrayList.Add(transform.localRotation.w.ToString());
				//myArrayList.Add(Time_Pre.ToString());
			}
		 	

			// float pos_x = transform.localPosition.x;
			// float pos_y = transform.localPosition.y;
			// float pos_z = transform.localPosition.z;
			// float rot_x = transform.localRotation.x;
			// float rot_y = transform.localRotation.y;
			// float rot_z = transform.localRotation.z;
			// float rot_w = transform.localRotation.w;
   //          var floatArray = new float[] {pos_x, pos_y, pos_z, rot_x, rot_y, rot_z, rot_w};
   //          var byteArray = new byte[floatArray.Length * 4];
   //          Buffer.BlockCopy(floatArray, 0, byteArray, 0, byteArray.Length);
   //          sendObj.sendByte(byteArray);

            //sendObj.sendString(x + y + z + rot_x + rot_y + rot_z + rot_w);
            //sendObj.sendString(transform.localPosition.x.ToString() + transform.localPosition.y.ToString() + transform.localPosition.z.ToString() +
            //transform.localRotation.x.ToString() + "  rot.y:" + transform.localRotation.y.ToString() + "  rot.z:" + transform.localRotation.z.ToString() + "  rot.w:" + transform.localRotation.w.ToString());
         
        }
	}

	SteamVR_Events.Action newPosesAction;




	void Awake()
	{
        //sendObj.Start();
        Debug.Log("Test TrackedObject for Initial");
        newPosesAction = SteamVR_Events.NewPosesAction(OnNewPoses);
	}

	void OnEnable()
	{
		var render = SteamVR_Render.instance;
		if (render == null)
		{
			enabled = false;
			return;
		}

		newPosesAction.enabled = true;
	}

	void OnDisable()
	{
		newPosesAction.enabled = false;
		isValid = false;
	}

	public void SetDeviceIndex(int index)
	{
		if (System.Enum.IsDefined(typeof(EIndex), index))
			this.index = (EIndex)index;
	}
}
