using UnityEngine;
using static WeaponManager;

public class LaserBeam : MonoBehaviour, IWeapon {
    private float rateOfFire = 0.4f;

    private void Update(){
        rateOfFire -= Time.unscaledDeltaTime;
    }

    public void Shoot(){
        if (rateOfFire <= 0f) {
            GameObject laserBeam = WeaponPool.Instance.Get(WeaponType.Laser);
            laserBeam.SetActive(true);
            rateOfFire = 0.4f;
        }
    }
}