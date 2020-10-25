using Actors.Player;
using UnityEngine;
using static Managers.WeaponManager;

namespace Actors.Weapons {
    public class LaserBeam : MonoBehaviour, IWeapon {
        private float _rateOfFire;
        [SerializeField] private float fireRate = 0.8f;
        public void Update(){
            _rateOfFire -= Time.unscaledDeltaTime;
        }

        public void Shoot(){
            if (_rateOfFire <= 0f) {
                GameObject laserBeam = WeaponPool.Instance.Get(WeaponType.Laser);
                laserBeam.SetActive(true);
                PlayerData.boostCharge -= 2f;
                _rateOfFire = fireRate;
            }
        }
    }
}