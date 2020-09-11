using UnityEngine;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    private PlayerData _playerData;

    private void Awake(){
        _playerData = GetComponentInParent<PlayerController>().playerData;
    }

    private void OnTriggerEnter(Collider other){
        Debug.Log("Collision with" + other.gameObject.tag);
        if (other.CompareTag("Player")) return;
        if (other.CompareTag("Shot")) return;

        if (other.CompareTag("Enemy")) {
            other.gameObject.GetComponent<EnemyController>().TakeDamage(_shieldDamage);
            gameObject.SetActive(false);
            _playerData.ShieldIsActive = false;
        }
    }
}