//======= Copyright (c) Valve Corporation, All rights reserved. ===============
//
// Purpose: For controlling in-game objects with tracked devices.
//
//=============================================================================

using UnityEngine;
using Valve.VR;

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
            //Debug.Log("Print out position" + transform.position.x);
            //if (index == EIndex.Device5)
            sendObj.sendString("pos.x:"+ transform.localPosition.x.ToString()+ "  pos.y:"+ transform.localPosition.y.ToString()+ "  pos.z:"+ transform.localPosition.z.ToString()+
            "  rot.x:" + transform.localRotation.x.ToString() + "  rot.y:" + transform.localRotation.y.ToString() + "  rot.z:" + transform.localRotation.z.ToString() + "  rot.w:" + transform.localRotation.w.ToString());
         
        }
	}

	SteamVR_Events.Action newPosesAction;

	void Awake()
	{
        sendObj.Start();
        //receiveObj.Start();
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

