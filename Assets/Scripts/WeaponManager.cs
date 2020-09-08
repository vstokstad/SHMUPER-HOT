using UnityEngine;
using Debug = System.Diagnostics.Debug;

public class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
    }

    public class PlasmaShot : MonoBehaviour, IWeapon {
        private GameObject _plasmaShot;
        private string _plasma = "PlasmaBall";
        private GameObject[] _plasmaShots;

        private PlayerData _playerData;
        private int _ammunition;
       
        private void Awake(){
            _playerData = this.GetComponent<PlayerMovement>().playerData;
            _ammunition = _playerData.ammunition; 
            _plasmaShots = new GameObject[_ammunition];
            for (int i = 0; i < _plasmaShots.Length; i++) {
                _plasmaShots[i] = Instantiate((Resources.Load(_plasma, typeof(GameObject)))) as GameObject;
                _plasmaShots[i].SetActive(false);
            }

            _ammunition -= 1;
        }

        public void Shoot(){
            Vector3 position = transform.position;
            Vector3 initialPosition = new Vector3(position.x + 1f, position.y, 0f);
            if (_ammunition < 0) return;
            int i = _ammunition;
            if (i >= 0 && _plasmaShots.Length > i) {
                _plasmaShot = _plasmaShots[i];
                _plasmaShot.SetActive(true);
                _plasmaShot.transform.position = initialPosition;
                _plasmaShot.GetComponent<Rigidbody>().velocity = this.GetComponent<Rigidbody>().velocity * 10f;
                
            }
           
           


        }
    }
}