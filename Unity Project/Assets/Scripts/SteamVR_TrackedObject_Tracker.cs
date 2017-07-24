﻿//======= Copyright (c) Valve Corporation, All rights reserved. ===============
//
// Purpose: For controlling in-game objects with tracked devices.
//
//=============================================================================

using UnityEngine;
using Valve.VR;
using System;
using System.Collections;
using System.IO;
//using Fromatter;
//using System.Fromatter;
using System.Runtime.Serialization.Formatters.Binary;


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

    UDPSend sendObj = new UDPSend();
    //UDPReceive receiveObj = new UDPReceive();




	void Save_Data(LocalData data)
	{
		BinaryFormatter bf = new BinaryFormatter();
		FileStream file = File.Create(Application.persistentDataPath + "data.dat");

		Debug.Log(Application.persistentDataPath);


		bf.Serialize(file, data);
		file.Close();
	}

[Serializable]
class LocalData
	{
		public string pos_x;
		public string pos_y;
		public string pos_z;
		public string rot_x;
		public string rot_y;
		public string rot_z;
		public string rot_w;

	}

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

			LocalData data = new LocalData();

			data.pos_x = transform.localPosition.x.ToString();
			data.pos_y = transform.localPosition.y.ToString();
			data.pos_z = transform.localPosition.z.ToString();
			data.rot_x = transform.localRotation.x.ToString();
			data.rot_y = transform.localRotation.y.ToString();
			data.rot_z = transform.localRotation.z.ToString();
			data.rot_w = transform.localRotation.w.ToString();


		 	Save_Data(data);

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
