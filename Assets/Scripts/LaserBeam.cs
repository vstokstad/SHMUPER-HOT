using UnityEngine;
using static WeaponManager;

public class LaserBeam : MonoBehaviour, IWeapon {
    private float _rateOfFire = 2f;

    private void Update(){
        _rateOfFire -= Time.unscaledDeltaTime;
    }

    public void Shoot(){
        if (_rateOfFire <= 0f) {
            GameObject laserBeam = WeaponPool.Instance.Get(WeaponType.Laser);
            laserBeam.SetActive(true);
            _rateOfFire = 2f;
        }
    }
}