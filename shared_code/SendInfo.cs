using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SendInfo : MonoBehaviour {
    public GameObject[] objects;
    public SendUDP sendUDP;
    // Use this for initialization
    void Start () {
        sendUDP = GameObject.Find("UDPConnection").GetComponent<SendUDP>();
    }
	
	// Update is called once per frame
	void Update () {

        sendUDP.messageToSend = System.DateTime.Now.ToString("HH:mm:ss") + ',' +
            objects[0].transform.position.x.ToString() + ',' +
            objects[0].transform.position.y.ToString() + ',' +
            objects[0].transform.position.z.ToString()+'\n';
        print(sendUDP.messageToSend);
        //print(objects[0].transform.position.ToString("F3")+ objects[1].transform.position.ToString("F3"));
    }
}
