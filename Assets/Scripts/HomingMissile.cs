using UnityEngine;
using static TagsAsStrings;
using static WeaponManager;

public class HomingMissile : MonoBehaviour, IWeapon {
    private GameObject _player;
    private float _rateOfFire = 0.5f;

    private void Update(){
        _rateOfFire -= Time.deltaTime;
    }


    private void OnEnable(){
        gameObject.SetActive(true);
        _player = GameObject.FindGameObjectWithTag(playerTag);
    }

    public void Shoot(){
        if (!RateOfFire()) return;
        GameObject missile = WeaponPool.Instance.Get(WeaponType.Missile);
        Transform transform1 = _player.transform;
        missile.transform.position = transform1.position;
        missile.gameObject.SetActive(true);
    }

    private bool RateOfFire(){
        if (!(_rateOfFire <= 0f)) return false;
        _rateOfFire = 0.5f;
        return true;
    }
}