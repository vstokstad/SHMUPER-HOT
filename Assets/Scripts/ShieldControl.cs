using UnityEngine;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    public bool shieldInput;
    private PlayerData _playerData;

    private void Awake(){
        _playerData = GetComponentInParent<PlayerController>().playerData;
    }

    private void Update(){
        if (shieldInput && _playerData.ShieldIsActive)
            gameObject.SetActive(true);
        else if (!_playerData.ShieldIsActive) gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Enemy")) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(_shieldDamage);
        _playerData.ShieldIsActive = false;
    }
}