using UnityEngine;

public class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
    }

    #region PlasmaShotWeaponType

    public class PlasmaShot : MonoBehaviour, IWeapon {
        private readonly string _plasma = "PlasmaBall";
        private int _ammunition;
        private GameObject _plasmaShot;
        private GameObject[] _plasmaShots;
        private Vector2 _plasmaVelocity;
        private PlayerData _playerData;
        private Rigidbody _playerRigidBody;

        private void Awake(){
            _playerRigidBody = GetComponent<Rigidbody>();
            _playerData = GetComponent<PlayerMovement>().playerData;
            _ammunition = _playerData.plasmaAmmunition;
            _plasmaShots = new GameObject[_ammunition];
            for (int i = 0; i < _plasmaShots.Length; i++) {
                _plasmaShots[i] = Instantiate(Resources.Load(_plasma, typeof(GameObject))) as GameObject;
                _plasmaShots[i].SetActive(false);
            }

            _ammunition -= 1;
        }

        public void Shoot(){
            Vector3 position = transform.position;
            Vector3 initialPosition = new Vector3(position.x + 1f, position.y, 0f);

            int i = _ammunition;
            if (i >= 0 && _plasmaShots.Length > i) {
                Vector3 velocity = _playerRigidBody.velocity;
                _plasmaVelocity = new Vector2(15f + velocity.x, Mathf.Sin(Mathf.PI * velocity.x));
                _plasmaShot = _plasmaShots[i];
                _plasmaShot.SetActive(true);
                _plasmaShot.transform.position = initialPosition;
                _plasmaShot.GetComponent<Rigidbody>().velocity = _plasmaVelocity;
                _ammunition -= 1;
            }
        }
    }

    #endregion
}