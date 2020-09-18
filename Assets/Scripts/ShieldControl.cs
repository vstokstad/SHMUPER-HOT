using System;
using UnityEngine;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    [NonSerialized] public bool shieldInput;
    private PlayerData _playerData;

    private void Awake(){
        _playerData = GetComponentInParent<PlayerController>().playerData;
    }

    private void Update(){
        if (shieldInput && _playerData.ShieldIsLoaded)
            gameObject.SetActive(true);
        else if (!_playerData.ShieldIsLoaded) gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Enemy") || !_playerData.ShieldIsLoaded) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(_shieldDamage);
        _playerData.ShieldIsLoaded = false;
    }
}