using UnityEngine;
using static GameManager;

public class WeaponPickUpManager : MonoBehaviour {
    private GameObject _missile, _laser;
    private WeaponController _weaponController;


    private void Awake(){
        _missile = GetComponentInChildren<MissilePickUp>(includeInactive: true).gameObject;
        _laser = GetComponentInChildren<LaserPickUp>(includeInactive: true).gameObject;
    }


    public void SpawnLaser(){
        _laser.SetActive(true);
        _laser.transform.position = CameraBounds;
    }

    public void SpawnMissiles(){
        _missile.SetActive(true);
        _missile.transform.position = CameraBounds;    
    }
}