using UnityEngine;
using static GameManager;

public class WeaponPickUpManager : MonoBehaviour {
    public PlayerController playerController;
    private GameObject _missile, _laser;
    private WeaponController _weaponController;


    private void Awake(){
        _missile = GetComponentInChildren(typeof(MissilePickUp)).gameObject;
        _laser = GetComponentInChildren(typeof(LaserPickUp)).gameObject;
    }


    public void SpawnLaser(){
        if (!(playerController.killCounter > 10f)) return;
        _laser.SetActive(true);
        _laser.transform.position = CameraBounds * 1.1f;
    }

    public void SpawnMissiles(){
        if (!(playerController.killCounter >= 20f)) return;
        _missile.SetActive(true);
        _missile.transform.position = CameraBounds * 1.1f;
    }
}